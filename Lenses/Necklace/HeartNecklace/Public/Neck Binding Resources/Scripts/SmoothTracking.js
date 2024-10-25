// -----JS CODE-----
// SmoothTracking.js
// Version: 0.1.0
// Event: On Awake, Update
// Description: Uses Euro Filter to smooth tracking between objects

// @input SceneObject[] smoothObjects;
// @input SceneObject target;

var posFilter;
var rotFilter;
var smoothedRot = [];
var smoothedPos = [];
var distanceFromCamera;
var camera;

var objHelpers = require("./SceneObjectHelpersModule");
var distanceThreshold = 70; //distance in centimeters
var updateEvent = script.createEvent("UpdateEvent");
updateEvent.enabled = false;

function smoothInitialization() {
    if (!validityCheck()) {
        return;
    }
    for (let index = 0; index < script.smoothObjects.length; index++) {
        smoothedRot[index] = script.smoothObjects[index].getTransform().getWorldRotation();
        smoothedPos[index] = script.smoothObjects[index].getTransform().getWorldPosition();
    }
    initVars();
    camera = objHelpers.getComponentInParentRecursive(script.getSceneObject(), "Camera");
    if (camera == null) {
        print("Place NeckBinding under a hieararchy with a camera");
        return;
    }
    camera = camera.getSceneObject();
    updateEvent.enabled = true;
}

updateEvent.bind(function() {
    var targetPos = script.target.getTransform().getWorldPosition();
    var targetRot = script.target.getTransform().getWorldRotation();
    var filteredPos = posFilter.filter(targetPos);
    var filteredRot = rotFilter.filter(targetRot);
    distanceFromCamera = camera.getTransform().getWorldPosition().distance(script.smoothObjects[0].getTransform().getWorldPosition());
    if (distanceFromCamera > distanceThreshold) { //don't use filter if distance is above threshold
        filteredPos = targetPos;
        filteredRot = targetRot;
    }
    for (let index = 0; index < script.smoothObjects.length; index++) {
        script.smoothObjects[index].getTransform().setWorldPosition(filteredPos.add(smoothedPos[index]));
        script.smoothObjects[index].getTransform().setLocalRotation(filteredRot.multiply(smoothedRot[index]));
    }
});

function validityCheck() {
    if (!script.smoothObjects || script.smoothObjects.length == 0 || !script.target || script.target.length == 0) {
        return false;
    }
    return true;
}

function initVars() {
    posFilter = new global.EuroFilter3D(30, 1, 1, 1);
    rotFilter = new global.EuroFilterQuat(30, 5, 0.01, 0.5);
}

/*API */
script.addObjectToSmooth = function(newTarget) {
    if (!script.smoothObjects) {
        script.smoothObjects = [];
    }
    script.smoothObjects.push(newTarget);
    smoothInitialization();
};
//#endregion API