const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    mobile: {
        type: Number,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    user_type: {
        type: String,
    },
    company_name: {
        type: String,
    },
    location: {
        type: String,
    }
});

const user = mongoose.model("user", userSchema);

module.exports = user;