// Main.js
//
// Wristwear Try On main controller
//
// 1. Set left and right object visibility to false on start 
//    so they don't show up before the tracker is initialized.
// 2. Hide hint when a wrist is being tracked
//
//
// From here on tracking and visibility is handled exclusively by the wrist binding custom component
//

//@input Component.ScriptComponent wristBindingCC
//@input SceneObject leftSo
//@input SceneObject rightSo
//@input SceneObject hintSo

function init() {
    script.leftSo.enabled = false;
    script.rightSo.enabled = false;

    script.wristBindingCC.onWristFound.add(function() {
        global.tweenManager.startTween(script.hintSo, "hint_out_1");
        global.tweenManager.startTween(script.hintSo, "hint_out_2");
        global.tweenManager.startTween(script.hintSo, "hint_out_3");
    });
}

function checkParams() {
    if (!script.wristBindingCC) {
        print("error: missing wristBindingCC input");
        return false;
    }
    if (!script.leftSo) {
        print("error: missing leftSo input");
        return false;
    }
    if (!script.rightSo) {
        print("error: missing rightSo input");
        return false;
    }
    if (!script.hintSo) {
        print("error: missing hintSo input");
        return false;
    }

    return true;
}

if (checkParams()) {
    init();
}
