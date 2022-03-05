var express = require('express');
var app = express();
var cloudinary = require('cloudinary').v2
var bodyParser = require('body-parser');
var dotenv = require("dotenv");
var admin = require('./routes/admin');
var teacher = require('./routes/teacher');
var student = require('./routes/student');
var post = require('./routes/post');
var port = process.env.PORT || 4000;

dotenv.config();

cloudinary.config({
    cloud_name: "dvfiu8y7o",
    api_key: "793879794985158",
    api_secret: "lO6KibEhXmFx33WBGRVQWACLw",
})

// Set up mongoose connection
var mongoose = require('mongoose');
mongoose.connect(process.env.DB_CONNECT, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
});
mongoose.Promise = global.Promise;
var db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use('/upload', express.static("upload"));
app.use(express.json());
app.use('/admin', admin);
app.use('/teacher', teacher);
app.use('/student', student);
app.use('/post', post);



app.listen(port, () => {
    console.log('Server is up and running on port numner ' + port);
});
