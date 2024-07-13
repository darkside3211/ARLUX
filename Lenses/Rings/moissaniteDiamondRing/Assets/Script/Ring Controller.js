//@input Component.ScriptComponent ringL
//@input Component.ScriptComponent ringR
//@input Component.ScriptComponent roulette

script.roulette.addCallbackOnSelection(ringChanged);

function ringChanged(){
    var finger_index = script.roulette.getSelectedButton();
    script.ringL.setFingerSelection(finger_index);
    script.ringR.setFingerSelection(finger_index);
    
}