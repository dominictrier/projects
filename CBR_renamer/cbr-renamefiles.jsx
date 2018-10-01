#target Photoshop

// CBR Renamer Script v1.0
// MAINTAINER: Dominic Trier and Jakob Bergdahl
// MAIL: dominic.trier@gmail.com

// bring Photoshop to Focus
app.bringToFront();
// record Dialog Settings
var docRef = 0;
// record Dialog Settings
var startDisplayDialogs = app.displayDialogs;
// Setup the Target Filenames
var oldtiffcode = "_3_m.";
var oldpngcode = "_5.";
//setup result filenames
var newtiffcode = "_b_m";
var newpngcode = "_5_1320x1320";
// check if document is open & define docRef
if (app.documents.length !== 0) {
    docRef = app.activeDocument;
}

// call Main Function
main();

// main function
function main() {
    // check if a valid file is opened
    if (docRef == 0) {
        // no valid file, warning and stopping
        alert("no open Document ... stopping");
        return false;
    }
    //check if the current open file is a target file
    if (fileName().indexOf(oldtiffcode) !== -1) {
        //disable dialogs
        app.displayDialogs = DialogModes.NO;
        // tiff file found
        saveTIFF();
        // restore dialogs
        app.displayDialogs = startDisplayDialogs;
    } else if (fileName().indexOf(oldpngcode) !== -1) {
        //disable dialogs
        app.displayDialogs = DialogModes.NO;
        // png file found
        savePNG();
        // restore dialogs
        app.displayDialogs = startDisplayDialogs;
    } else {
        // other file found
        alert("no valid file opened ... stopping");
        return false;
    }
}

// get full file name (path + filename)
function fullFileName() {
    var fullName = docRef.fullName;
    var fullNameStr = fullName + "";
    return fullNameStr;
}

// get filename (name + extension)
function fileName() {
    var fileName = docRef.name;
    var fileNameStr = fileName.split(".");
    fileNameStr = fileNameStr[0] + "." + fileNameStr[1];
    return fileNameStr;
}

// get path from current file
function savePath() {
    var savePath = fullFileName().replace(fileName(), "");
    return savePath;
}

//get split name
function splitName() {
    var splitNameStr = docRef.name.split("_");
    return splitNameStr[0];
}

// tiff save function
function saveTIFF() {
    // setup new file name
    var newfile = File(savePath() + splitName() + newtiffcode + ".tif");
    // tiff save options
    tiffSaveOptions = new TiffSaveOptions();
    tiffSaveOptions.embedColorProfile = true;
    tiffSaveOptions.alphaChannels = true;
    tiffSaveOptions.layers = true;
    tiffSaveOptions.imageCompression = TIFFEncoding.TIFFLZW;
    tiffSaveOptions.layerCompression = LayerCompression.RLE;
    docRef.saveAs(newfile, tiffSaveOptions, true, Extension.LOWERCASE);
    docRef.close(SaveOptions.DONOTSAVECHANGES);
}

// png save function
function savePNG() {
    // setup new filename
    var newfile = File(savePath() + splitName() + newpngcode + ".png");
    // png save options
    PNGoptions = new PNGSaveOptions();
    PNGoptions.compression = 0;
    PNGoptions.interlaced = false;
    // save and close document
    docRef.saveAs(newfile, PNGoptions, true, Extension.LOWERCASE);
    docRef.close(SaveOptions.DONOTSAVECHANGES);
}
