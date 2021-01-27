const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({
    mobile: {
        type: Number,
        required: true
    }
});

const otpLogin = mongoose.model("otpLogin", otpSchema);

module.exports = otpLogin;