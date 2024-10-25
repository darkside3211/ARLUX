// -----JS CODE-----
// Ear Enable Object By Index.js
// Version: 1.0
// Event: Awake
// Description: Enable scene object by its index in the input array, will disable the rest of the scene object

// @input SceneObject[] sceneObjects 

script.enableObject = function(index) {
    for (var i = 0; i < script.sceneObjects.length; i++) {
        if (i==index) {
            script.sceneObjects[i].enabled = true;
        } else {
            script.sceneObjects[i].enabled = false;
        }
    }
};