// EuroFilterExtension.js
// Version: 0.1.0
// Event: On Awake
// Description: Extends functionaly of EuroFilter script
//

function createFilter(freq, mincutoff, beta, dcutoff) {
    return new global.OneEuroFilter(freq, mincutoff, beta, dcutoff);
}

global.EuroFilter1D = function(freq, mincutoff, beta, dcutoff) {
    this._x = createFilter(freq, mincutoff, beta, dcutoff);
};

global.EuroFilter1D.prototype.filter = function(val) {
    var t = getTime();
    return this._x.filter(val, t);
};

global.EuroFilter1D.prototype.setParams = function(newMinCutOff, newBeta) {
    this._x.setMincutoff(newMinCutOff);
    this._x.setBeta(newBeta);
};

global.EuroFilter1D.prototype.cutoff = function() {
    return this._x.lastcutoff || 1000;
};

global.EuroFilter2Djoint = function(freq, mincutoff, beta, dcutoff) {
    this._xy = new global.OneEuroFilterXY(freq, mincutoff, beta, dcutoff);
};

global.EuroFilter2Djoint.prototype.filter = function(vec) {
    var t = getTime();
    var vec_out = this._xy.filter(vec.x, vec.y, t);
    return new vec2(vec_out[0], vec_out[1]);
};

global.EuroFilter2Djoint.prototype.setParams = function(newMinCutOff, newBeta) {
    this._xy.setMincutoff(newMinCutOff);
    this._xy.setBeta(newBeta);
};

global.EuroFilter2Djoint.prototype.cutoff = function() {
    return this._xy.lastcutoff || 1000;
};

global.EuroFilter3D = function(freq, mincutoff, beta, dcutoff) {
    this._xyz = new global.OneEuroFilter3D(freq, mincutoff, beta, dcutoff);
};

global.EuroFilter3D.prototype.filter = function(vec) {
    var t = getTime();
    var vec_out = this._xyz.filter(vec.x, vec.y, vec.z, t);
    return new vec3(vec_out[0], vec_out[1], vec_out[2]);
};

global.EuroFilter3D.prototype.setParams = function(newMinCutOff, newBeta) {
    this._xyz.setMincutoff(newMinCutOff);
    this._xyz.setBeta(newBeta);
};

global.EuroFilter3D.prototype.cutoff = function() {
    return this._xyz.lastcutoff || 1000;
};

global.EuroFilterQuat = function(freq, mincutoff, beta, dcutoff) {
    this.filterQuat  = new global.OneEuroFilterQuat(freq, mincutoff, beta, dcutoff);
};

global.EuroFilterQuat.prototype.filter = function(curQuat) {
    var t = getTime();
    var quat_rot_and_speed = this.filterQuat.filter(curQuat, t);
    var quat_rot = quat_rot_and_speed[0];
    quat_rot.normalize();
    return quat_rot;
};

global.EuroFilterQuat.prototype.setParams = function(newMinCutOff, newBeta) {
    this.filterQuat.setMincutoff(newMinCutOff);
    this.filterQuat.setBeta(newBeta);
};

global.EuroFilterQuat.prototype.cutoff = function() {
    return this.filterQuat.lastcutoff || 1000;
};

