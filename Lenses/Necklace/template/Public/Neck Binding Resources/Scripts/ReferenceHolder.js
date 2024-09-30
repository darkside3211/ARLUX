// -----JS CODE-----
// ReferenceHolder.js
// Version: 0.1.0
// Event: On Awake
// Description: Hold reference object from prefabs, needed for neck binding script

//@input Component.ScriptComponent smoothTracking
//@input SceneObject neckAttachmentPoint
//@input Component.ObjectTracking3D bodyTracking
//@input SceneObject bodyMeshOccluder
//@input SceneObject neckMeshOccluder

script.getSmoothTracker = function() {
    return script.smoothTracking;
};
