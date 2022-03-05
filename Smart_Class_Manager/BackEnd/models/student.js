var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var StudentSchema = new Schema({
    _id: {
        type: Number,
        required: true
    },
    fullName: {
        type: String,
        required: true
    },
    dept: {
        type: String,
        required: true
    },
    sem: {
        type: Number,
        required: true
    },
    mail: {
        type: String
    },
    password: {

        type: String,
        required: true
    }
});


// Export the model
module.exports = mongoose.model('students', StudentSchema);