const mongoose = require("mongoose");
const User = require("./user")

const bookTruckSchema = new mongoose.Schema({
    bid_amount: {
        type: Number,
        required: true
    },
    amount_type: {
        type: String,
        required: true
    },
    negotiable: {
        type: String,
        required: true
    },
    uid: {
        type: mongoose.Schema.Types.ObjectId,
        ref: User,
        required: true
    },
    date: {
        type: Date,
        required: true
    }
});

const bookTruck = mongoose.model("bookTruck", bookTruckSchema);

module.exports = bookTruck;