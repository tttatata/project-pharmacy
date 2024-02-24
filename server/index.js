/*client ->middleware-> server -> client*/

// import from pakages
const express = require("express");
const mongoose = require("mongoose");
const DB = "mongodb+srv://thanhtranthai2233:thanhtranthai2233@cluster0.uavllxt.mongodb.net/?retryWrites=true&w=majority";
// import from other files
const authRouter = require('./routes/auth');
//init
const PORT = 3000;
const app = express();
// middleware
app.use(express.json());
app.use(authRouter);

//Connections
mongoose.connect(DB).then(() => {
    console.log("kết nối thành công csdl");

}).catch((e) => {
    console.log(e);
});
app.listen(PORT, "0.0.0.0", () => {
    console.log(`kết nối bằng port ${PORT}`);
});
//localhost
