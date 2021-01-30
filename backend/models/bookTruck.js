const mongoose = require("mongoose");
const User = require("./user")
const Fleet = require("./fleet");

const bookTruckSchema = new mongoose.Schema({
    bid_amount: {
        type: Number,
        required: true
    },
    rate_negotiable: {
        type: Boolean,
        default: null
    },
    need_immediately: {
        type: Boolean,
        default: null
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
    loadType: {
        type: String,
    },
    confirmed: {
        type: Boolean,
        default: null
    }
});

const bookTruck = mongoose.model("bookTruck", bookTruckSchema);

module.exports = bookTruck;