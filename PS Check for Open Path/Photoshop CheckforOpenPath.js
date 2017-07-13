#target Photoshop

checkopenpath();

function checkopenpath() {
    if (!documents.length) return;
    try {
        var status = true;
        var Path = app.activeDocument.pathItems.getByName("Path 1");
        for (var b = 0; b < Path.subPathItems.length; b++) {
            if (!Path.subPathItems[b].closed) {
                status = false;
            }
        }
        if (!status) {
            alert("PATH NOT CLOSED!");
        }
    }
    catch (e) {
        alert('cannot select "Pfad 1"');
    }
}
