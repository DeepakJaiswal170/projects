var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var RoutineSchema = new Schema({
    _id: {type: String, required: true},
    dept: {type: String, required: true},
    sem: {type: String, required: true},
    monday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    },
    tuesday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    },
    wednesday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    },
    thursday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    },
    friday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    },
    saturday: {
        period_1: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_2: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "09:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_3: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "10:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_4: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "11:40 AM"},
            duration: {type: Number, default: 50},
        },
        period_5: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "1:10 AM"},
            duration: {type: Number, default: 50},
        },
        period_6: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:00 AM"},
            duration: {type: Number, default: 50},
        },
        period_7: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "2:50 AM"},
            duration: {type: Number, default: 50},
        },
        period_8: {
            subject: {type: String, default: "No Class"},
            teacher: {type: String, default: "N/A"},
            time: {type: String, default: "3:40 AM"},
            duration: {type: Number, default: 50},
        },

    }
});


// Export the model
module.exports = mongoose.model('student_routines', RoutineSchema);