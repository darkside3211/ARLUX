/**
 * Author: Gery Casiez
 * Details: http://cristal.univ-lille.fr/~casiez/1euro/
 *
 * Copyright 2019 Inria
 *
 * BSD License https://opensource.org/licenses/BSD-3-Clause
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
 * and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or
 * promote products derived from this software without specific prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/**
 *
 * Modified 2022 Snap Inc.
 *
 */

var eps = 0.00001;
var minimum_dt = 1.0 / 120.0;

// Makes sure dt is never 0 or negative
function SafelyClampPeriod(dt) {
    return Math.max(dt, minimum_dt);
}

function ConvertMomentumToCutoff(momentum, rate) {
    return (1 / (momentum + eps) - 1) * rate / (2 * Math.PI);
}

function ConvertCutoffToMomentum(cutoff, rate) {
    // Clamp extreme values to ensure momentum can be 0 or 1
    if (cutoff <= 0) {
        return 1;
    }
    if (cutoff >= 40000) {
        return 0;
    }
    return 1 - 1 / (1 + rate / (2 * Math.PI * (cutoff + eps)));
}

var LowPassFilter = function(alpha, initval) {
    initval = initval || 0;
    this.y = this.s = initval;
    this.setAlpha(alpha);
    this.initialized = false;
};

LowPassFilter.prototype = {
    setAlpha(alpha) {
        if (alpha <= 0.0 || alpha > 1.0) {
            print("alpha should be in (0.0., 1.0]");
        }
        this.a = alpha;
    },

    filter(value) {
        var result;
        if (this.initialized) {
            result = this.a * value + (1.0 - this.a) * this.s;
        } else {
            result = value;
            this.initialized = true;
        }
        this.y = value;
        this.s = result;
        return result;
    },

    filterWithAlpha(value, alpha) {
        this.setAlpha(alpha);
        return this.filter(value);
    },

    hasLastRawValue() {
        return this.initialized;
    },

    lastRawValue() {
        return this.y;
    },

    reset() {
        this.initialized = false;
    }
};



var OneEuroFilter = function(freq, mincutoff, beta_, dcutoff) {
    mincutoff = mincutoff || 1;
    beta_ = beta_ || 0;
    dcutoff = dcutoff || 1;

    this.setFrequency(freq);
    this.setMinCutoff(mincutoff);
    this.setBeta(beta_);
    this.setDerivateCutoff(dcutoff);
    this.x = new LowPassFilter(this.alpha(mincutoff));
    this.dx = new LowPassFilter(this.alpha(dcutoff));
    this.lasttime = undefined;
    this.lastcutoff = undefined;
};


OneEuroFilter.prototype = {
    alpha(cutoff) {
        var te = 1.0 / this.freq;
        var tau = 1.0 / (2 * Math.PI * cutoff);
        return 1.0 / (1.0 + tau/te);
    },

    setFrequency(f) {
        if (f <= 0) {
            print("freq should be >0") ;
        }
        this.freq = f;
    },

    setMinCutoff(mc) {
        if (mc<=0) {
            print("mincutoff should be >0");
        }
        this.mincutoff = mc;
    },

    setBeta(b) {
        this.beta_ = b;
    },

    setDerivateCutoff(dc) {
        if (dc <= 0) {
            print("dcutoff should be >0");
        }
        this.dcutoff = dc ;
    },

    reset() {
        this.x.reset();
        this.dx.reset();
        this.lasttime = undefined;
        this.lastcutoff = undefined;
    },

    filter(value, timestamp) {
        // update the sampling frequency based on timestamps
        if (this.lasttime !== undefined && timestamp !== undefined) {
            this.freq = 1.0 / SafelyClampPeriod(timestamp - this.lasttime);
        }
        this.lasttime = timestamp;
        // estimate the current variation per second
        var dvalue = this.x.hasLastRawValue() ? (value - this.x.lastRawValue())*this.freq : 0.0;
        var edvalue = this.dx.filterWithAlpha(dvalue, this.alpha(this.dcutoff));

        // use it to update the cutoff frequency
        var cutoff = this.mincutoff + this.beta_ * Math.abs(edvalue);
        this.lastcutoff = cutoff;

        // filter the given value
        return this.x.filterWithAlpha(value, this.alpha(cutoff));
    }
};

var OneEuroFilterXY = function(freq, mincutoff, beta_, dcutoff) {
    mincutoff = mincutoff || 1;
    beta_ = beta_ || 0;
    dcutoff = dcutoff || 1;

    this.setFrequency(freq);
    this.setMinCutoff(mincutoff);
    this.setBeta(beta_);
    this.setDerivateCutoff(dcutoff);
    this.x = new LowPassFilter(this.alpha(mincutoff));
    this.dx = new LowPassFilter(this.alpha(dcutoff));
    this.y = new LowPassFilter(this.alpha(mincutoff));
    this.dy = new LowPassFilter(this.alpha(dcutoff));
    this.lasttime = undefined;
    this.lastcutoff = undefined;
};


OneEuroFilterXY.prototype = {
    alpha(cutoff) {
        var te = 1.0 / this.freq;
        var tau = 1.0 / (2 * Math.PI * cutoff);
        return 1.0 / (1.0 + tau/te);
    },

    setFrequency(f) {
        if (f<=0) {
            print("freq should be >0");
        }
        this.freq = f;
    },

    setMinCutoff(mc) {
        if (mc<=0) {
            print("mincutoff should be >0");
        }
        this.mincutoff = mc;
    },

    setBeta(b) {
        this.beta_ = b;
    },

    setDerivateCutoff(dc) {
        if (dc<=0) {
            print("dcutoff should be >0");
        }
        this.dcutoff = dc;
    },

    reset() {
        this.x.reset();
        this.dx.reset();
        this.y.reset();
        this.dy.reset();
        this.lasttime = undefined;
        this.lastcutoff = undefined;
    },

    filter(value_x, value_y, timestamp) {
        // update the sampling frequency based on timestamps
        if (this.lasttime !== undefined && timestamp !== undefined) {
            this.freq = 1.0 / SafelyClampPeriod(timestamp - this.lasttime);
        }
        this.lasttime = timestamp;
        // estimate the current variation per second
        var dvalue_x = this.x.hasLastRawValue() ? (value_x - this.x.lastRawValue())*this.freq : 0.0;
        var dvalue_y = this.y.hasLastRawValue() ? (value_y - this.y.lastRawValue())*this.freq : 0.0;

        var edvalue_x = this.dx.filterWithAlpha(dvalue_x, this.alpha(this.dcutoff));
        var edvalue_y = this.dy.filterWithAlpha(dvalue_y, this.alpha(this.dcutoff));

        var edvalue_xy_norm = Math.sqrt(Math.pow(edvalue_x, 2) + Math.pow(edvalue_y, 2));

        // use it to update the cutoff frequency
        var cutoff = this.mincutoff + this.beta_ * Math.abs(edvalue_xy_norm);
        this.lastcutoff = cutoff;

        // filter the given value
        var x_out = this.x.filterWithAlpha(value_x, this.alpha(cutoff));
        var y_out = this.y.filterWithAlpha(value_y, this.alpha(cutoff));
        return [x_out, y_out];
    }
};

var OneEuroFilter3D = function(freq, mincutoff, beta_, dcutoff) {
    mincutoff = mincutoff || 1;
    beta_ = beta_ || 0;
    dcutoff = dcutoff || 1;

    this.setFrequency(freq);
    this.setMinCutoff(mincutoff);
    this.setBeta(beta_);
    this.setDerivateCutoff(dcutoff);
    this.x = new LowPassFilter(this.alpha(mincutoff));
    this.y = new LowPassFilter(this.alpha(mincutoff));
    this.z = new LowPassFilter(this.alpha(mincutoff));
    this.speed = new LowPassFilter(this.alpha(dcutoff), 0);
    this.lasttime = undefined;
    this.lastcutoff = undefined;
};


OneEuroFilter3D.prototype = {
    alpha(cutoff) {
        var te = 1.0 / this.freq;
        var tau = 1.0 / (2 * Math.PI * cutoff);
        return 1.0 / (1.0 + tau/te);
    },

    setFrequency(f) {
        if (f<=0) {
            print("freq should be >0");
        }
        this.freq = f;
    },

    setMinCutoff(mc) {
        if (mc<=0) {
            print("mincutoff should be >0");
        }
        this.mincutoff = mc;
    },

    setBeta(b) {
        this.beta_ = b;
    },

    setDerivateCutoff(dc) {
        if (dc<=0) {
            print("dcutoff should be >0");
        }
        this.dcutoff = dc;
    },

    reset() {
        this.x.reset();
        this.y.reset();
        this.z.reset();
        this.speed.reset();
        this.lasttime = undefined;
        this.lastcutoff = undefined;
    },

    filter(value_x, value_y, value_z, timestamp) {
        // update the sampling frequency based on timestamps
        if (this.lasttime !== undefined && timestamp !== undefined) {
            this.freq = 1.0 / SafelyClampPeriod(timestamp - this.lasttime);
        }
        this.lasttime = timestamp;
        // estimate the current variation per second
        var dvalue_x = this.x.hasLastRawValue() ? (value_x - this.x.lastRawValue())*this.freq : 0.0;
        var dvalue_y = this.y.hasLastRawValue() ? (value_y - this.y.lastRawValue())*this.freq : 0.0;
        var dvalue_z = this.z.hasLastRawValue() ? (value_z - this.z.lastRawValue())*this.freq : 0.0;

        var edvalue_xyz_norm = Math.sqrt(Math.pow(dvalue_x, 2) + Math.pow(dvalue_y, 2) + Math.pow(dvalue_z, 2));
        var new_speed = this.speed.filterWithAlpha(edvalue_xyz_norm, this.alpha(this.dcutoff));

        // use it to update the cutoff frequency
        var cutoff = this.mincutoff + this.beta_ * Math.abs(new_speed);
        this.lastcutoff = cutoff;

        // filter the given value
        var x_out = this.x.filterWithAlpha(value_x, this.alpha(cutoff));
        var y_out = this.y.filterWithAlpha(value_y, this.alpha(cutoff));
        var z_out = this.z.filterWithAlpha(value_z, this.alpha(cutoff));
        return [x_out, y_out, z_out];
    }
};

var OneEuroFilterQuat = function(freq, mincutoff, beta_, dcutoff) {
    mincutoff = mincutoff || 1;
    beta_ = beta_ || 0;
    dcutoff = dcutoff || 1;

    this.setFrequency(freq);
    this.setMinCutoff(mincutoff);
    this.setBeta(beta_);
    this.setDerivateCutoff(dcutoff);

    this.lasttime = undefined;
    this.q_prev_rot = undefined;
    this.speed = new LowPassFilter(this.alpha(dcutoff), 0);
    this.lastcutoff = undefined;
};

OneEuroFilterQuat.prototype = {
    alpha(cutoff) {
        var te = 1.0 / this.freq;
        var tau = 1.0 / (2 * Math.PI * cutoff);
        return 1.0 / (1.0 + tau/te);
    },

    setFrequency(f) {
        if (f<=0) {
            print("freq should be >0");
        }
        this.freq = f;
    },

    setMinCutoff(mc) {
        if (mc<=0) {
            print("mincutoff should be >0");
        }
        this.mincutoff = mc;
    },

    setBeta(b) {
        this.beta_ = b;
    },

    setDerivateCutoff(dc) {
        if (dc<=0) {
            print("dcutoff should be >0");
        }
        this.dcutoff = dc;
    },

    filter(q_new_rot, timestamp) {
        // update the sampling frequency based on timestamps
        if (this.lasttime !== undefined && timestamp!== undefined) {
            this.freq = 1.0 / SafelyClampPeriod(timestamp - this.lasttime);
        }
        this.lasttime = timestamp;

        q_new_rot.normalize();
        if (this.q_prev_rot === undefined) {
            this.q_prev_rot = q_new_rot;
        }

        var delta = q_new_rot.dot(this.q_prev_rot);
        var mag = Math.max(-1, Math.min(1, 2*delta*delta - 1));
        var delta_angle = Math.acos(mag);
        var new_speed = delta_angle * this.freq;
        
        var filtered_speed = this.speed.filterWithAlpha(new_speed, this.alpha(this.dcutoff));
        // use it to update the cutoff frequency
        var cutoff = this.mincutoff + this.beta_ * Math.abs(filtered_speed);

        this.lastcutoff = cutoff;
        var rotation_alpha = this.alpha(cutoff);
        var new_rotation = quat.slerp(this.q_prev_rot, q_new_rot, rotation_alpha);
        new_rotation.normalize();

        this.q_prev_rot = new_rotation;

        return [new_rotation, new_speed];
    }
};

global.OneEuroFilter = OneEuroFilter;
global.OneEuroFilterXY = OneEuroFilterXY;
global.OneEuroFilter3D = OneEuroFilter3D;
global.OneEuroFilterQuat = OneEuroFilterQuat;
global.SafelyClampPeriod = SafelyClampPeriod;
global.ConvertCutoffToMomentum = ConvertCutoffToMomentum;
global.ConvertMomentumToCutoff = ConvertMomentumToCutoff;