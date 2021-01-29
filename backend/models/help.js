const mongoose = require("mongoose");
const User = require("./user")

const helpSchema = new mongoose.Schema({
    department: {
        type: String,
        required: true
    },
    issue: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        default: Date.now()
    },
    uid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: User,
        required: true
    }
});

const help = mongoose.model("help", helpSchema);

module.exports = help;