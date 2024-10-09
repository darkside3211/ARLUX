// -----JS CODE-----
// Zoom Btn Ctrl.js
// Version: 1.0
// Event: Tap 
// Description: on tap will enable the zoom object and call the 'zoom enable' button

//@input Component.ScriptComponent btnCtrl
//@input SceneObject zoomObj

var isAvailable = false;

script.createEvent("TapEvent").bind(function() {
    if (!isAvailable) {
        return;
    }
    
    script.btnCtrl.hide();
    script.zoomObj.enabled = true;
});

script.setStatus = function(data) {
    isAvailable = data;
};