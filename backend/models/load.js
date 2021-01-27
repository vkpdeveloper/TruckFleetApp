const mongoose = require("mongoose");
const User = require("./user")

const loadSchema = new mongoose.Schema({
    pickup_location: {
        type: String,
        required: true
    },
    drop_location: {
        type: String,
        required: true
    },
    load_weight: {
        type: String,
        required: true
    },
    load_rate: {
        type: Number,
        required: true
    },
    load_type: {
        type: String
    },
    date: {
        type: Date,
        default: Date.now()
    },
    uid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: User,
        required: true
    },
    truck_require: {
        type: String,
        required: true
    }
});

const load = mongoose.model("load", loadSchema);

module.exports = load;