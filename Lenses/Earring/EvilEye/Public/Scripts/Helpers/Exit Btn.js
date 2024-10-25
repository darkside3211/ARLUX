// -----JS CODE-----
// Exit Button.js
// Version: 1.0
// Event: Tap 
// Description: on tap will disable the zoom object and call the 'zoom enable' button

//@input Component.ScriptComponent btnCtrl
//@input SceneObject zoomObj

script.createEvent("TapEvent").bind(function() {
    script.btnCtrl.show();
    script.zoomObj.enabled = false;
});