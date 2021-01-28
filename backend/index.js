const app = require("./serverApp");
const User = require("./models/user");
const Fleet = require("./models/fleet");
const Load = require("./models/load");
const BookLoad = require("./models/bookLoad");
const BookTruck = require("./models/bookTruck");
const mongoose = require("mongoose");
const load = require("./models/load");
const fleet = require("./models/fleet");
const multer = require("multer")
const path = require("path")

const diskStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, `${__dirname}/uploads`);
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname + path.extname(file.originalname));
    }
});

const upload = multer(
    {
        storage: diskStorage,
    }
);

mongoose.connect("mongodb://localhost:27017/shreem", { useUnifiedTopology: true, useNewUrlParser: true })

app.get("/", (req, res) => {
    res.send({
        success: "Server started running properly"
    })
});

app.post("/register", upload.fields([{
    name: 'aadhaar', maxCount: 1
}, {
    name: 'pan', maxCount: 1
}]), async (req, res) => {
    try {
        const { email, name, mobile, user_type, company_name, location } = req.body;
        const createUser = new User({
            email,
            name,
            mobile,
            user_type,
            company_name,
            location
        });
        const response = await createUser.save();
        res.send({
            success: true,
            result: "User registered successfully",
            response: response
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.post("/add_fleet", async (req, res) => {
    try {
        const { pickup_location, drop_location, truck_number, fleet_rate, fleet_capacity, fleet_type, uid } = req.body;
        const addFleet = new Fleet({
            pickup_location,
            drop_location,
            truck_number,
            fleet_rate,
            fleet_capacity,
            fleet_type,
            uid
        });
        const response = await addFleet.save();
        res.send({
            success: true,
            result: "Fleet added successfully"
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.post("/add_load", async (req, res) => {
    try {
        const { pickup_location, drop_location, load_weight, load_rate, load_type, date, uid, truck_require } = req.body;
        const addLoad = new Load({
            pickup_location,
            drop_location,
            load_weight,
            load_rate,
            load_type,
            date,
            uid,
            truck_require
        });
        const response = await addLoad.save();
        res.send({
            success: true,
            result: "Load added successfully"
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.post("/otp_login", async (req, res) => {
    try {
        const { mobile } = req.body;
        const otpLogin = new otpLogin({
            mobile
        });
        const response = await otpLogin.save();
        res.send({
            success: true,
            result: "Otp sent successfully"
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.post("/book_truck", async (req, res) => {
    try {
        const { bid_amount, amount_type, negotiable, uid, date } = req.body;
        const BookTruck = new BookTruck({
            bid_amount,
            amount_type,
            negotiable,
            uid,
            date
        });
        const response = await BookTruck.save();
        res.send({
            success: true,
            result: "Booked truck successfully"
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.post("/book_load", async (req, res) => {
    try {
        const { bid_amount, amount_type, negotiable, availability, fid, uid } = req.body;
        const createLoad = new BookLoad({
            bid_amount,
            amount_type,
            negotiable,
            availability,
            fid,
            uid
        });
        const response = await createLoad.save();
        res.send({
            success: true,
            result: "Booked Load successfully"
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
})

app.get("/get_load", async (req, res) => {
    try {
        const allLoads = await load.find({});
        res.send({
            data: allLoads
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_fleet", async (req, res) => {
    try {
        const allFleet = await fleet.find({});
        res.send({
            data: allFleet
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_load_by_user", async (req, res) => {
    const { uid } = req.headers;
    try {
        const allLoadsByUser = await load.find({
            uid: uid
        });
        res.send({
            data: allLoadsByUser
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_fleet_by_user", async (req, res) => {
    const { uid } = req.headers;
    try {
        const allFleetbyUser = await fleet.find({
            uid: uid
        });
        res.send({
            data: allFleetbyUser
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_bookLoad", async (req, res) => {
    const { uid } = req.headers;
    try {
        const allBookLoads = await BookLoad.find({
            uid: uid
        }).populate("fid", "pickup_location drop_location load_weight load_rate load_type date uid truck_require");
        res.send({
            data: allBookLoads
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_bookTruck", async (req, res) => {
    const { uid } = req.headers;
    try {
        const allBookTruck = await BookTruck.find({
            uid: uid
        });
        res.send({
            data: allBookTruck
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.get("/get_bookTruck", async (req, res) => {
    const { uid } = req.headers;
    try {
        const allBookTruck = await BookTruck.find({
            uid: uid
        });
        res.send({
            data: allBookTruck
        })
    } catch (e) {
        res.send({
            error: e.message
        })
    }
});

app.post('/edit_profile', async (req, res) => {
    const { uid, name, email, company_name, location } = req.body;
    try {
        const editProfile = await User.updateOne({

            _id: uid
        }, {
            name,
            email,
            company_name,
            location

        });
        res.send({
            success: true,
            data: editProfile
        })
    } catch (e) {
        res.send({
            success: false,
            error: e.message
        })
    }
});

app.get("/profile", async (req, res) => {
    const { uid } = req.headers;
    const user = await User.findOne({
        _id: uid
    });
    res.send({
        success: true,
        data: {
            response: user
        }
    })
})

app.post("/check_login", async (req, res) => {
    const { mobile } = req.body;
    const user = await User.findOne({ mobile });
    if (user) {
        res.send({
            success: true,
            data: {
                response: user
            }
        })
    } else {
        res.send({
            success: false,
            result: "No user found"
        })
    }
})

app.listen(3000);