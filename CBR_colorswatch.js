#target photoshop


// CBR Colorbox Script v1.3
// MAINTAINER: Dominic Trier
// MAIL: dominic.trier@gmail.com


// Give Focus to Photoshop
app.bringToFront();
// save current Preferences
var startRulerUnits = app.preferences.rulerUnits;
var startTypeUnits = app.preferences.typeUnits;
var startDisplayDialogs = app.displayDialogs;
// Setup Rules & Units to PIXEL
app.preferences.rulerUnits = Units.PIXELS;
app.preferences.typeUnits = TypeUnits.PIXELS;
// Setup Swatch Variables
var swatchHeight = 180; // Swatch Size X
var swatchWidth = 180; // Swatch Size Y
var DPI = 300 // Image DPI
// ask for Input and Output Folder
var inputFolder = Folder.selectDialog("Ordner mit Colorbox Bildern auswaehlen");
var outputFolder = inputFolder + '/' + "output";
var safeFolder = Folder(outputFolder);
//Check if it exist, if not create it.
if (!safeFolder.exists) {
    safeFolder.create();
}
app.displayDialogs = DialogModes.NO;
var fileList = inputFolder.getFiles(/\.tif$/i);
for (var i = 0; i < fileList.length; i++) {
    open(fileList[i]);
    // setup swatch selection
    var docRef = app.activeDocument;
    var docHeight = docRef.height;
    var docWidth = docRef.width;
    var selRegion = Array(Array(docWidth / 2 - swatchWidth / 2, docHeight / 2 - swatchHeight / 2), Array(docWidth / 2 - swatchWidth / 2, docHeight / 2 + swatchHeight / 2), Array(docWidth / 2 + swatchWidth / 2, docHeight / 2 + swatchHeight / 2), Array(docWidth / 2 + swatchWidth / 2, docHeight / 2 - swatchHeight / 2));
    docRef.selection.select(selRegion);
    //make selection interactive
    var outsideInput = true;
    if (outsideInput) {
        app.displayDialogs = DialogModes.ALL;
        docRef.crop(docRef.selection.bounds);
        app.displayDialogs = DialogModes.NO;
    }
    else {
        docRef.crop(docRef.selection.bounds);
    }
    // Fit Image into Swatch Size
    if (docRef.height > docRef.width) {
        docRef.resizeImage(new UnitValue(swatchHeight, "px"), null, null, ResampleMethod.BICUBIC);
    }
    else {
        docRef.resizeImage(null, new UnitValue(swatchWidth, "px"), null, ResampleMethod.BICUBIC);
    }
    // format canvas if size does not match
    if (docWidth !== swatchWidth && docWidth !== swatchHeight) {
        docRef.resizeCanvas(new UnitValue(swatchWidth, 'px'), new UnitValue(swatchHeight, 'px'));
    }
    // change mode from LAB to RGB
    docRef.changeMode(ChangeMode.RGB);
    // change 16bits to 8bits if needed
    if (docRef.bitsPerChannel == BitsPerChannelType.SIXTEEN) {
        docRef.bitsPerChannel = BitsPerChannelType.EIGHT;
    }
    if (docRef.resolution != 300) {
        activeDocument.resizeImage(null, null, DPI, ResampleMethod.NONE);
    }
    // setup new file name and save path
    var newName = docRef.name.replace(/[^0-9].*/, "_1");
    var savePath = File(outputFolder + '/' + newName + '.png');
    // setup png save options
    PNGoptions = new PNGSaveOptions();
    PNGoptions.compression = 0;
    PNGoptions.interlaced = false;
    // save and close document
    docRef.saveAs(savePath, PNGoptions, true, Extension.LOWERCASE);
    docRef.close(SaveOptions.DONOTSAVECHANGES);
}
// Reset the application preferences
app.preferences.rulerUnits = startRulerUnits;
app.preferences.typeUnits = startTypeUnits;
app.displayDialogs = startDisplayDialogs;


// changelog:
// v1.2 added automatic output folder
// v1.3 removed open folder function