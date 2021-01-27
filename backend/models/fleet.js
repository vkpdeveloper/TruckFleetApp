const mongoose = require("mongoose");
const User = require("./user")

const fleetSchema = new mongoose.Schema({
    pickup_location: {
        type: String,
        required: true
    },
    drop_location: {
        type: String,
        required: true
    },
    truck_number: {
        type: String,
        required: true
    },
    fleet_rate: {
        type: Number,
        required: true
    },
    fleet_capacity: {
        type: String
    },
    fleet_type: {
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

const fleet = mongoose.model("fleet", fleetSchema);

module.exports = fleet;