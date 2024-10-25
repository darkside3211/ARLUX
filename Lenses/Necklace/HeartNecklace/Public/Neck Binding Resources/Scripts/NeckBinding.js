// -----JS CODE-----
// Neck Binding.js
// Version: 0.1.0
// Event: On Awake
// Description: Attach model to track the neck, using body tracking component and Euro Filter to minimize jitter

// @input bool useOccluders = true
// @input bool useColliders = true
// @input bool showColliders = false {"showIf":"useColliders", "useColliders":"true"}

// @input bool advanced
// @input Asset.ObjectPrefab helpers {"showIf":"advanced", "showIfValue":"true"} //helper scene objects - body tracking, body mesh occluder
// @input Asset.ObjectPrefab colliders {"showIf":"advanced", "showIfValue":"true"} //helper collider objects - chest, neck
// @input Asset.ObjectPrefab euroFilter {"showIf":"advanced", "showIfValue":"true"} //euro filters

const EURO_FILTER = "Euro Filter";

var objHelpers = require("./SceneObjectHelpersModule");
var DestructionHelper = require("./DestructionHelper");
var manager = new DestructionHelper(script);

var sceneObject;
var parent;
var bodyTracking;
var collidersSO;
var necklaceParentSO;
var helpersSO;
var bodyMeshOccluderSO;
var neckMeshOccluderSO;
var numOfChildren;
var referenceHolder;

script.createEvent("OnDisableEvent").bind(disableEvent);
script.createEvent("OnEnableEvent").bind(enableEvent);
script.createEvent("OnStartEvent").bind(init);

function init() {
    if (!inputValid()) {
        return;
    }
    sceneObject = script.getSceneObject();
    parent = sceneObject.getParent();
    necklaceParentSO = manager.createSceneObject(null);
    numOfChildren = sceneObject.getChildrenCount();
    //set necklace parent
    for (var i = numOfChildren - 1; i >= 0; i--) {
        var child = sceneObject.getChild(i);
        child.setParentPreserveWorldTransform(necklaceParentSO);
        setChildrenLayerRecursive(child, sceneObject.layer);
    }
    // set all objects under custom component to have the same layer as the component
    necklaceParentSO.setParentPreserveWorldTransform(sceneObject);  
    var euroFilter = objHelpers.findObjectWithName(EURO_FILTER);
    if (!euroFilter) {
        euroFilter = script.euroFilter.instantiate(parent);
    }

    helpersSO = script.helpers.instantiate(parent);
    setChildrenLayerRecursive(helpersSO, sceneObject.layer);
    referenceHolder = helpersSO.getComponent("Component.ScriptComponent");
    if (!referenceHolder||!referenceHolder.smoothTracking.addObjectToSmooth) {
        return;
    }
    referenceHolder.smoothTracking.addObjectToSmooth(sceneObject);
    setOccluders(script.useOccluders);
    collidersSO = script.colliders.instantiate(sceneObject);
    setChildrenLayerRecursive(collidersSO, sceneObject.layer);

    bodyTracking = referenceHolder.bodyTracking;
    bodyTracking.onTrackingLost = function() {
        trackingLost(); 
    };
    bodyTracking.onTrackingStarted = function() {
        trackingStarted(); 
    };
    setColliders(script.useColliders, script.showColliders);
}

function setOccluders(state) {
    bodyMeshOccluderSO = referenceHolder.bodyMeshOccluder;
    neckMeshOccluderSO = referenceHolder.neckMeshOccluder;
    bodyMeshOccluderSO.layer = sceneObject.layer;
    neckMeshOccluderSO.layer = sceneObject.layer;
    bodyMeshOccluderSO.enabled = state;
    neckMeshOccluderSO.enabled = state;
}

function setColliders(useColliders, showColliders) {
    var colliders = objHelpers.getComponentsRecursive(collidersSO, "Physics.ColliderComponent");
    for (var index = 0; index < colliders.length; index++) {
        colliders[index].enabled = useColliders;
        colliders[index].debugDrawEnabled = showColliders;
    }
}

function inputValid() {
    if (!script.helpers) {
        print("Error, missing helpers prefab");
        return false;
    } 
    if (!script.colliders) {
        print("Error, missing colliders prefab");
        return false;
    }   
    
    if (!script.euroFilter) {
        print("Error, missing Euro Filter prefab");
        return false;
    }

    
    
    return true;
}
function trackingLost() {
    collidersSO.enabled = false;
    if (necklaceParentSO) {
        necklaceParentSO.enabled = false;
    }
}

function trackingStarted() {
    collidersSO.enabled = true;
    if (necklaceParentSO) {
        necklaceParentSO.enabled = true;
    }
}


function disableEvent() {
    if (necklaceParentSO) {
        necklaceParentSO.enabled = false;
    }
}

function enableEvent() {
    if (bodyTracking && bodyTracking != undefined) {
        bodyTracking.enabled = true;
    }
    if (necklaceParentSO && necklaceParentSO != undefined) {
        necklaceParentSO.enabled = true;
    }
}

function setChildrenLayerRecursive(sceneObjectToSet, layer) {
    numOfChildren = sceneObjectToSet.getChildrenCount();
    for (var i = 0; i < numOfChildren ; i++) {
        if (i >= sceneObjectToSet.getChildrenCount()) {
            return;
        }
        var child = sceneObjectToSet.getChild(i);
        child.layer = layer;
        if (child.getChildrenCount() > 0) {
            setChildrenLayerRecursive(child, layer);
        }
    }
}

