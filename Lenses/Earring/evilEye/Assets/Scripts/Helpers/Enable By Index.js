// -----JS CODE-----
// Ear Enable Object By Index.js
// Version: 1.0
// Event: Awake
// Description: Enable scene object by its index in the input array, will disable the rest of the scene object

// @input SceneObject[] objectReferences 

script.enableObject = function(index) {
    for (var i = 0; i < script.objectReferences.length; i++) {
        if (i==index) {
            script.objectReferences[i].enabled = true;
        } else {
            script.objectReferences[i].enabled = false;
        }
    }
};