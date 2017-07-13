#target photoshop

app.bringToFront();
var inputFolder = Folder.selectDialog("select folder to process");              //select input folder
var outputFolder = Folder.selectDialog("folder for save");           			//select output folder
OpenFolder();

function OpenFolder() {
    app.displayDialogs = DialogModes.NO;                                        //deactivate Dialog Modes
    try {
        var fileList = inputFolder.getFiles(/\.tif$|\.psd$/i);                  //get Tif and Psd Files from selected Folder
    }
    catch (e) {
        alert("No Files selected");
        throw new Error("No Files selected");
    }
    for (var i = 0; i < fileList.length; i++) {                                 //cycle all files in folder and open
        open(fileList[i]);
        var docRef = app.activeDocument;
        var newName = docRef.name.split(".");                                   //split filename for suffix
        var savePath = File(outputFolder + '/' + newName[0] + '.tif');          //generate new safe path
        try {
            app.doAction(“ACTIONNAME”, “ACTIONSET.atn")                         //run photoshop action
        }
        catch (e) {
            alert("Something went wrong!");
            throw new Error("Something went wrong!");
        }
        tiffSaveOptions = new TiffSaveOptions();                                // setup tif save options
        tiffSaveOptions.embedColorProfile = true;
        tiffSaveOptions.alphaChannels = true;
        tiffSaveOptions.layers = true;
        tiffSaveOptions.imageCompression = TIFFEncoding.TIFFLZW;
        tiffSaveOptions.layerCompression = LayerCompression.ZIP;
        docRef.saveAs(savePath, tiffSaveOptions, true, Extension.LOWERCASE);
        docRef.close(SaveOptions.DONOTSAVECHANGES);
    }
}
