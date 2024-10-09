// -----JS CODE-----
// EarringAPIExample.js
// Version: 1.0
// Event: Update
// Description: Example script to show how to use Ear Binding Custom Component API.
//@input Component.ScriptComponent earBinding  {"label" : "Ear Binding","hint": "Add Ear Binding Custom Component"}
//@input bool cycleEars = true;
//@input bool cycleLandmarks = true;
//@input float timeBetweenChange = 0.7;






var landmarkTimer = 0, positionTimer = 0;
const ear = ["Left", "Right"];

script.createEvent("OnStartEvent").bind(function() {     
    script.createEvent("UpdateEvent").bind(update);
})

function update() {
    if (script.cycleLandmarks) {
        setNextLandmark();
    }

    if (script.cycleEars) {
        changeEar();
    }
}

var currentLandmark = 0;

function setNextLandmark() {
    landmarkTimer += getDeltaTime();
    if (landmarkTimer > script.timeBetweenChange) {
        if (++currentLandmark >= script.earBinding.getLandmarkNames().length) {
            currentLandmark = 0;
        }
        script.earBinding.setEarringLandmark(script.earBinding.script.EarLandmark[currentLandmark]);
        landmarkTimer = 0;
    }
}

var earIndex = 0;
function changeEar() {
    positionTimer += getDeltaTime();
    if (positionTimer > script.timeBetweenChange) {
        if (++earIndex >= ear.length) {
            earIndex = 0;
        }
        script.earBinding.setEarSelection(ear[earIndex]);
        positionTimer = 0;
    }
}
