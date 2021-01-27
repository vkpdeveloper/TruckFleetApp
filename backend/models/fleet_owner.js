const mongoose = require("mongoose");

const ownerSchema = new mongoose.Schema({
    user_id: {
        type: Number,
        required: true
    },
    owner_id: {
        type: Number,
        required: true
    },
    company_name: {
        type: String,
        required: true
    },
    company_location: {
        type: Number,
        required: true
    },

});

const fleet_owner = mongoose.model("fleet_owner", ownerSchema);

module.exports = fleet_owner;