// -----JS CODE-----
// Btn Animation.js
// Version: 1.0
// Event: Update
// Description: Moves the button ribbon to the right of the screen 

//@input Component.ScreenTransform screenTransform
//@input Component.ScriptComponent zoomBtnController

var btnObj = script.screenTransform.getSceneObject();
var anchors = script.screenTransform.anchors;
var posFactor = 0.06;
var scaleFactor = 1.3;
var anchorLFrom;
var anchorLTo;
var anchorRFrom;
var anchorRTo;
var anchorRScale;

var startTime;
var scaleDir = 1;
var moveDir = 1;
var extraPush = false;
var push = true;
var isAvailable = false;

btnObj.enabled = false;

var updateEvent = script.createEvent("UpdateEvent");
updateEvent.enabled = false;
updateEvent.bind(update);

script.createEvent("OnStartEvent").bind(function() {
    init();
});


const DURATION = 0.3;

function init() {  
    var curSize = anchors.getSize();    
    
    anchorLTo = -1;
    anchorRTo = anchors.right;
    anchorRFrom = -1;
    var offset = (anchorRTo - anchorRFrom) * (0.5 + posFactor);

    anchorRFrom -= offset;
    anchorLFrom = anchorLTo - offset;
    
    anchorRScale = anchors.left + curSize.x * scaleFactor;
    
    anchors.left = anchorLFrom;
    anchors.right = anchorRFrom;
        
    btnObj.enabled = true;
    extraPush = false;
    push = true;
}

function show() {   
    startTime = getTime();
    moveDir = 1;
    updateEvent.enabled = true;
    extraPush = false;
    push = true;
}

function hide() {
    isAvailable = false;
    startTime = getTime();
    moveDir = -1;
    updateEvent.enabled = true;
    extraPush = false;
    push = true;
}

function update() {
    var val = (getTime() - startTime) / DURATION;
    val = clamp(val, 0, 1);
    
    if (moveDir == -1 || scaleDir == -1) {
        val = 1 - val;
    }
    if (extraPush) {
        anchors.right = anchorRTo + (anchorRScale - anchorRTo) * val;
    } else if (push) {
        anchors.left = anchorLFrom + (anchorLTo - anchorLFrom) * val;
        anchors.right = anchorRFrom + (anchorRTo - anchorRFrom) * val;    
    }

    if (val >= 1 && moveDir == 1 && !extraPush) {
        startTime = getTime();
        scaleDir = 1;
        extraPush = true;
        push = false;
    }
    
    if (val <= 0 && moveDir == -1) {
        push = false;
    }

    if (val >= 1 && scaleDir == 1 && extraPush) {
        scaleDir = -1;
        startTime = getTime();
    }
    
    if (val <= 0 && scaleDir == -1 && extraPush) {
        isAvailable = true;
        script.zoomBtnController.setStatus(isAvailable);
        extraPush = false;
    }
}

script.show = show;
script.hide = hide;

function clamp(val, min, max) {
    return Math.min(Math.max(val, min), max);
}