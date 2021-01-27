const mongoose = require("mongoose");
const User = require("./user")
const Fleet = require("./load");

const bookLoadSchema = new mongoose.Schema({
    bid_amount: {
        type: Number,
        required: true
    },
    amount_type: {
        type: String,
        required: true
    },
    negotiable: {
        type: Boolean,
        required: true
    },
    availability: {
        type: Boolean,
        required: true
    },
    fid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: Fleet,
        required: true
    },
    uid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: User,
        required: true
    },
    date: {
        type: Date,
        default: Date.now()
    },
    confirmed: {
        type: Boolean,
        default: null
    }
});

const bookLoad = mongoose.model("bookLoad", bookLoadSchema);

module.exports = bookLoad;