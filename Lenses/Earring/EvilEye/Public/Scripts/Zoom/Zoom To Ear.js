// -----JS CODE-----
// Zoom To Ear.js
// Version: 1.0
// Event: Update
// Description: Controls Zoom CC, selects which object is Zoom's point of interest according to head rotation

//@ui {"widget":"label", "label":"Zoom Controls"}
//@typename ZoomImage
//@input ZoomImage zoomImage
//@input SceneObject leftEar
//@input SceneObject rightEar

var focusOnLeftEar = true;
var objectRotation;
var headBinding;

const ROTATION_THRESHOLD = 0.21;
var objHelpers = require("./SceneObjectHelpersModule");

script.createEvent("UpdateEvent").bind(readRotation);
script.createEvent("OnStartEvent").bind(init);

function init() {
    script.zoomImage.enabled = true;
    headBinding = objHelpers.getOrAddComponent(script.getSceneObject().getParent(), "Head");
}

function readRotation() {
    if (script.zoomImage.getSceneObject().isEnabledInHierarchy) {
        objectRotation = headBinding.getTransform().forward.x;
        if (Math.abs(objectRotation) > ROTATION_THRESHOLD) {
            //cutout zoom ctrl
            if (objectRotation < 0 && focusOnLeftEar) {
                script.zoomImage.setZoomTrackedObject(script.rightEar);
                focusOnLeftEar = false;
            }
            if (objectRotation > 0 && !focusOnLeftEar) {
                script.zoomImage.setZoomTrackedObject(script.leftEar);
                focusOnLeftEar = true;
            }
        }  
    }
   
}
