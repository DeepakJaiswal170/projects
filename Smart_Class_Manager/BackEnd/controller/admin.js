var Student = require('../models/student');
var Teacher = require('../models/teacher');
var StudentRoutine = require('../models/student_routine');
var TeacherRoutine = require('../models/teacher_routine')

var dotenv = require("dotenv");
var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");

//Simple version, without validation or sanitation
exports.test = function (req, res) {
  res.send('Greetings from the Test controller!');
};

//admin access for student database

exports.student_create = async function (req, res, next) {
  const salt = await bcrypt.genSalt(10);
  const password = await bcrypt.hash(req.body.password, salt);
    var student = new Student(
        {
            _id: req.body._id,
            fullName: req.body.fullName,
            dept: req.body.dept,
            sem: req.body.sem,
            mail: req.body.mail,
            password,
        }
    );

    student.save(function (err) {
        if (err) return next(err);
        res.send('Student Added successfully');
    })
};

exports.student_view_all = function (req, res, next) {
    Student.find({ dept: req.params.dept }, (err, result) => {
        if (err) return res.json(err);
        return res.json({ data: result });
    });
};

exports.student_details = function (req, res, next) {
    Student.findById(req.params.id, function (err, student) {
        if (err) return next(err);
        res.send(student);
    })
};

exports.student_change_password = async function (req, res, next) {
  const salt = await bcrypt.genSalt(10);
  const password = await bcrypt.hash(req.body.password, salt);
  await Student.updateOne(
    { "_id": req.body._id },
    { $set: { "password": password } },
    res.send('Password Updated,')
   );
};

exports.student_update = function (req, res, next) {
    Student.findByIdAndUpdate(req.params.id, { $set: req.body }, function (err, student) {
        if (err) return next(err);
        res.send('Information udpated.');
    });
};

exports.student_delete = function (req, res, next) {
    Student.findByIdAndRemove(req.params.id, function (err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};

//admin access for teachers database

exports.teacher_create = async function (req, res, next) {
    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);
      var teacher = new Teacher(
          {
              _id: req.body._id,
              fullName: req.body.fullName,
              dept: req.body.dept,
              mail: req.body.mail,
              password,
          }
      );
  
      teacher.save(function (err) {
          if (err) return next(err);
          res.send('Teacher Added successfully');
      })
};
  
exports.teacher_view_all = function (req, res, next) {
    Teacher.find({ dept: req.params.dept }, (err, result) => {
        if (err) return res.json(err);
        return res.json({ data: result });
    });
};
  
  exports.teacher_details = function (req, res, next) {
      Teacher.findById(req.params.id, function (err, teacher) {
          if (err) return next(err);
          res.send(teacher);
      })
  };
  
  exports.teacher_change_password = async function (req, res, next) {
    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);
    await Teacher.updateOne(
      { "_id": req.body._id },
      { $set: { "password": password } },
      res.send('Password Updated,')
     );
  };
  
  exports.teacher_update = function (req, res, next) {
      Teacher.findByIdAndUpdate(req.params.id, { $set: req.body }, function (err, teacher) {
          if (err) return next(err);
          res.send('Information udpated.');
      });
  };
  
  exports.teacher_delete = function (req, res, next) {
      Teacher.findByIdAndRemove(req.params.id, function (err) {
          if (err) return next(err);
          res.send('Deleted successfully!');
      })
};
  

// admin access for class routine

exports.create_student_routine = function (req, res, next) {
    var routine = new StudentRoutine(
        {
            _id: req.body.dept+"-"+req.body.sem,
            dept: req.body.dept,
            sem: req.body.sem,
            monday: {
                period_1: {
                    subject: req.body.mon_p1_sub,
                    teacher: req.body.mon_p1_teach,
                    time: req.body.mon_p1_time,
                    duration: req.body.mon_p1_dur,
                },
                period_2: {
                    subject: req.body.mon_p2_sub,
                    teacher: req.body.mon_p2_teach,
                    time: req.body.mon_p2_time,
                    duration: req.body.mon_p2_dur,
                },
                period_3: {
                    subject: req.body.mon_p3_sub,
                    teacher: req.body.mon_p3_teach,
                    time: req.body.mon_p3_time,
                    duration: req.body.mon_p3_dur,
                },
                period_4: {
                    subject: req.body.mon_p4_sub,
                    teacher: req.body.mon_p4_teach,
                    time: req.body.mon_p4_time,
                    duration: req.body.mon_p4_dur,
                },
                period_5: {
                    subject: req.body.mon_p5_sub,
                    teacher: req.body.mon_p5_teach,
                    time: req.body.mon_p5_time,
                    duration: req.body.mon_p5_dur,
                },
                period_6: {
                    subject: req.body.mon_p6_sub,
                    teacher: req.body.mon_p6_teach,
                    time: req.body.mon_p6_time,
                    duration: req.body.mon_p6_dur,
                },
                period_7: {
                    subject: req.body.mon_p7_sub,
                    teacher: req.body.mon_p7_teach,
                    time: req.body.mon_p7_time,
                    duration: req.body.mon_p7_dur,
                },
                period_8: {
                    subject: req.body.mon_p8_sub,
                    teacher: req.body.mon_p8_teach,
                    time: req.body.mon_p8_time,
                    duration: req.body.mon_p8_dur,
                },
        
            },
            tuesday: {
                period_1: {
                    subject: req.body.tue_p1_sub,
                    teacher: req.body.tue_p1_teach,
                    time: req.body.tue_p1_time,
                    duration: req.body.tue_p1_dur,
                },
                period_2: {
                    subject: req.body.tue_p2_sub,
                    teacher: req.body.tue_p2_teach,
                    time: req.body.tue_p2_time,
                    duration: req.body.tue_p2_dur,
                },
                period_3: {
                    subject: req.body.tue_p3_sub,
                    teacher: req.body.tue_p3_teach,
                    time: req.body.tue_p3_time,
                    duration: req.body.tue_p3_dur,
                },
                period_4: {
                    subject: req.body.tue_p4_sub,
                    teacher: req.body.tue_p4_teach,
                    time: req.body.tue_p4_time,
                    duration: req.body.tue_p4_dur,
                },
                period_5: {
                    subject: req.body.tue_p5_sub,
                    teacher: req.body.tue_p5_teach,
                    time: req.body.tue_p5_time,
                    duration: req.body.tue_p5_dur,
                },
                period_6: {
                    subject: req.body.tue_p6_sub,
                    teacher: req.body.tue_p6_teach,
                    time: req.body.tue_p6_time,
                    duration: req.body.tue_p6_dur,
                },
                period_7: {
                    subject: req.body.tue_p7_sub,
                    teacher: req.body.tue_p7_teach,
                    time: req.body.tue_p7_time,
                    duration: req.body.tue_p7_dur,
                },
                period_8: {
                    subject: req.body.tue_p8_sub,
                    teacher: req.body.tue_p8_teach,
                    time: req.body.tue_p8_time,
                    duration: req.body.tue_p8_dur,
                },
        
            },
            wednesday: {
                period_1: {
                    subject: req.body.wed_p1_sub,
                    teacher: req.body.wed_p1_teach,
                    time: req.body.wed_p1_time,
                    duration: req.body.wed_p1_dur,
                },
                period_2: {
                    subject: req.body.wed_p2_sub,
                    teacher: req.body.wed_p2_teach,
                    time: req.body.wed_p2_time,
                    duration: req.body.wed_p2_dur,
                },
                period_3: {
                    subject: req.body.wed_p3_sub,
                    teacher: req.body.wed_p3_teach,
                    time: req.body.wed_p3_time,
                    duration: req.body.wed_p3_dur,
                },
                period_4: {
                    subject: req.body.wed_p4_sub,
                    teacher: req.body.wed_p4_teach,
                    time: req.body.wed_p4_time,
                    duration: req.body.wed_p4_dur,
                },
                period_5: {
                    subject: req.body.wed_p5_sub,
                    teacher: req.body.wed_p5_teach,
                    time: req.body.wed_p5_time,
                    duration: req.body.wed_p5_dur,
                },
                period_6: {
                    subject: req.body.wed_p6_sub,
                    teacher: req.body.wed_p6_teach,
                    time: req.body.wed_p6_time,
                    duration: req.body.wed_p6_dur,
                },
                period_7: {
                    subject: req.body.wed_p7_sub,
                    teacher: req.body.wed_p7_teach,
                    time: req.body.wed_p7_time,
                    duration: req.body.wed_p7_dur,
                },
                period_8: {
                    subject: req.body.wed_p8_sub,
                    teacher: req.body.wed_p8_teach,
                    time: req.body.wed_p8_time,
                    duration: req.body.wed_p8_dur,
                },
        
            },
            thursday: {
                period_1: {
                    subject: req.body.thu_p1_sub,
                    teacher: req.body.thu_p1_teach,
                    time: req.body.thu_p1_time,
                    duration: req.body.thu_p1_dur,
                },
                period_2: {
                    subject: req.body.thu_p2_sub,
                    teacher: req.body.thu_p2_teach,
                    time: req.body.thu_p2_time,
                    duration: req.body.thu_p2_dur,
                },
                period_3: {
                    subject: req.body.thu_p3_sub,
                    teacher: req.body.thu_p3_teach,
                    time: req.body.thu_p3_time,
                    duration: req.body.thu_p3_dur,
                },
                period_4: {
                    subject: req.body.thu_p4_sub,
                    teacher: req.body.thu_p4_teach,
                    time: req.body.thu_p4_time,
                    duration: req.body.thu_p4_dur,
                },
                period_5: {
                    subject: req.body.thu_p5_sub,
                    teacher: req.body.thu_p5_teach,
                    time: req.body.thu_p5_time,
                    duration: req.body.thu_p5_dur,
                },
                period_6: {
                    subject: req.body.thu_p6_sub,
                    teacher: req.body.thu_p6_teach,
                    time: req.body.thu_p6_time,
                    duration: req.body.thu_p6_dur,
                },
                period_7: {
                    subject: req.body.thu_p7_sub,
                    teacher: req.body.thu_p7_teach,
                    time: req.body.thu_p7_time,
                    duration: req.body.thu_p7_dur,
                },
                period_8: {
                    subject: req.body.thu_p8_sub,
                    teacher: req.body.thu_p8_teach,
                    time: req.body.thu_p8_time,
                    duration: req.body.thu_p8_dur,
                },
        
            },
            friday: {
                period_1: {
                    subject: req.body.fri_p1_sub,
                    teacher: req.body.fri_p1_teach,
                    time: req.body.fri_p1_time,
                    duration: req.body.fri_p1_dur,
                },
                period_2: {
                    subject: req.body.fri_p2_sub,
                    teacher: req.body.fri_p2_teach,
                    time: req.body.fri_p2_time,
                    duration: req.body.fri_p2_dur,
                },
                period_3: {
                    subject: req.body.fri_p3_sub,
                    teacher: req.body.fri_p3_teach,
                    time: req.body.fri_p3_time,
                    duration: req.body.fri_p3_dur,
                },
                period_4: {
                    subject: req.body.fri_p4_sub,
                    teacher: req.body.fri_p4_teach,
                    time: req.body.fri_p4_time,
                    duration: req.body.fri_p4_dur,
                },
                period_5: {
                    subject: req.body.fri_p5_sub,
                    teacher: req.body.fri_p5_teach,
                    time: req.body.fri_p5_time,
                    duration: req.body.fri_p5_dur,
                },
                period_6: {
                    subject: req.body.fri_p6_sub,
                    teacher: req.body.fri_p6_teach,
                    time: req.body.fri_p6_time,
                    duration: req.body.fri_p6_dur,
                },
                period_7: {
                    subject: req.body.fri_p7_sub,
                    teacher: req.body.fri_p7_teach,
                    time: req.body.fri_p7_time,
                    duration: req.body.fri_p7_dur,
                },
                period_8: {
                    subject: req.body.fri_p8_sub,
                    teacher: req.body.fri_p8_teach,
                    time: req.body.fri_p8_time,
                    duration: req.body.fri_p8_dur,
                },
        
            },
            saturady: {
                period_1: {
                    subject: req.body.sat_p1_sub,
                    teacher: req.body.sat_p1_teach,
                    time: req.body.sat_p1_time,
                    duration: req.body.sat_p1_dur,
                },
                period_2: {
                    subject: req.body.sat_p2_sub,
                    teacher: req.body.sat_p2_teach,
                    time: req.body.sat_p2_time,
                    duration: req.body.sat_p2_dur,
                },
                period_3: {
                    subject: req.body.sat_p3_sub,
                    teacher: req.body.sat_p3_teach,
                    time: req.body.sat_p3_time,
                    duration: req.body.fri_p3_dur,
                },
                period_4: {
                    subject: req.body.sat_p4_sub,
                    teacher: req.body.sat_p4_teach,
                    time: req.body.sat_p4_time,
                    duration: req.body.sat_p4_dur,
                },
                period_5: {
                    subject: req.body.sat_p5_sub,
                    teacher: req.body.sat_p5_teach,
                    time: req.body.sat_p5_time,
                    duration: req.body.sat_p5_dur,
                },
                period_6: {
                    subject: req.body.sat_p6_sub,
                    teacher: req.body.sat_p6_teach,
                    time: req.body.sat_p6_time,
                    duration: req.body.sat_p6_dur,
                },
                period_7: {
                    subject: req.body.sat_p7_sub,
                    teacher: req.body.sat_p7_teach,
                    time: req.body.sat_p7_time,
                    duration: req.body.sat_p7_dur,
                },
                period_8: {
                    subject: req.body.sat_p8_sub,
                    teacher: req.body.sat_p8_teach,
                    time: req.body.sat_p8_time,
                    duration: req.body.sat_p8_dur,
                },
        
            }
        }
    );
    routine.save(function (err) {
        if (err) return next(err);
        res.send('Students Routine Added Successfully For '+req.body.dept+'-'+req.body.sem+' Semester');
    })
}

exports.create_teacher_routine = function (req, res, next) {
    var routine = new TeacherRoutine(
        {
            _id: req.body.dept+"-"+req.body._id,
            monday: {
                period_1: {
                    subject: req.body.mon_p1_sub,
                    room: req.body.mon_p1_teach,
                    time: req.body.mon_p1_time,
                    duration: req.body.mon_p1_dur,
                },
                period_2: {
                    subject: req.body.mon_p2_sub,
                    room: req.body.mon_p2_teach,
                    time: req.body.mon_p2_time,
                    duration: req.body.mon_p2_dur,
                },
                period_3: {
                    subject: req.body.mon_p3_sub,
                    room: req.body.mon_p3_teach,
                    time: req.body.mon_p3_time,
                    duration: req.body.mon_p3_dur,
                },
                period_4: {
                    subject: req.body.mon_p4_sub,
                    room: req.body.mon_p4_teach,
                    time: req.body.mon_p4_time,
                    duration: req.body.mon_p4_dur,
                },
                period_5: {
                    subject: req.body.mon_p5_sub,
                    room: req.body.mon_p5_teach,
                    time: req.body.mon_p5_time,
                    duration: req.body.mon_p5_dur,
                },
                period_6: {
                    subject: req.body.mon_p6_sub,
                    room: req.body.mon_p6_teach,
                    time: req.body.mon_p6_time,
                    duration: req.body.mon_p6_dur,
                },
                period_7: {
                    subject: req.body.mon_p7_sub,
                    room: req.body.mon_p7_teach,
                    time: req.body.mon_p7_time,
                    duration: req.body.mon_p7_dur,
                },
                period_8: {
                    subject: req.body.mon_p8_sub,
                    room: req.body.mon_p8_teach,
                    time: req.body.mon_p8_time,
                    duration: req.body.mon_p8_dur,
                },
        
            },
            tuesday: {
                period_1: {
                    subject: req.body.tue_p1_sub,
                    room: req.body.tue_p1_teach,
                    time: req.body.tue_p1_time,
                    duration: req.body.tue_p1_dur,
                },
                period_2: {
                    subject: req.body.tue_p2_sub,
                    room: req.body.tue_p2_teach,
                    time: req.body.tue_p2_time,
                    duration: req.body.tue_p2_dur,
                },
                period_3: {
                    subject: req.body.tue_p3_sub,
                    room: req.body.tue_p3_teach,
                    time: req.body.tue_p3_time,
                    duration: req.body.tue_p3_dur,
                },
                period_4: {
                    subject: req.body.tue_p4_sub,
                    room: req.body.tue_p4_teach,
                    time: req.body.tue_p4_time,
                    duration: req.body.tue_p4_dur,
                },
                period_5: {
                    subject: req.body.tue_p5_sub,
                    room: req.body.tue_p5_teach,
                    time: req.body.tue_p5_time,
                    duration: req.body.tue_p5_dur,
                },
                period_6: {
                    subject: req.body.tue_p6_sub,
                    room: req.body.tue_p6_teach,
                    time: req.body.tue_p6_time,
                    duration: req.body.tue_p6_dur,
                },
                period_7: {
                    subject: req.body.tue_p7_sub,
                    room: req.body.tue_p7_teach,
                    time: req.body.tue_p7_time,
                    duration: req.body.tue_p7_dur,
                },
                period_8: {
                    subject: req.body.tue_p8_sub,
                    room: req.body.tue_p8_teach,
                    time: req.body.tue_p8_time,
                    duration: req.body.tue_p8_dur,
                },
        
            },
            wednesday: {
                period_1: {
                    subject: req.body.wed_p1_sub,
                    room: req.body.wed_p1_teach,
                    time: req.body.wed_p1_time,
                    duration: req.body.wed_p1_dur,
                },
                period_2: {
                    subject: req.body.wed_p2_sub,
                    room: req.body.wed_p2_teach,
                    time: req.body.wed_p2_time,
                    duration: req.body.wed_p2_dur,
                },
                period_3: {
                    subject: req.body.wed_p3_sub,
                    room: req.body.wed_p3_teach,
                    time: req.body.wed_p3_time,
                    duration: req.body.wed_p3_dur,
                },
                period_4: {
                    subject: req.body.wed_p4_sub,
                    room: req.body.wed_p4_teach,
                    time: req.body.wed_p4_time,
                    duration: req.body.wed_p4_dur,
                },
                period_5: {
                    subject: req.body.wed_p5_sub,
                    room: req.body.wed_p5_teach,
                    time: req.body.wed_p5_time,
                    duration: req.body.wed_p5_dur,
                },
                period_6: {
                    subject: req.body.wed_p6_sub,
                    room: req.body.wed_p6_teach,
                    time: req.body.wed_p6_time,
                    duration: req.body.wed_p6_dur,
                },
                period_7: {
                    subject: req.body.wed_p7_sub,
                    room: req.body.wed_p7_teach,
                    time: req.body.wed_p7_time,
                    duration: req.body.wed_p7_dur,
                },
                period_8: {
                    subject: req.body.wed_p8_sub,
                    room: req.body.wed_p8_teach,
                    time: req.body.wed_p8_time,
                    duration: req.body.wed_p8_dur,
                },
        
            },
            thursday: {
                period_1: {
                    subject: req.body.thu_p1_sub,
                    room: req.body.thu_p1_teach,
                    time: req.body.thu_p1_time,
                    duration: req.body.thu_p1_dur,
                },
                period_2: {
                    subject: req.body.thu_p2_sub,
                    room: req.body.thu_p2_teach,
                    time: req.body.thu_p2_time,
                    duration: req.body.thu_p2_dur,
                },
                period_3: {
                    subject: req.body.thu_p3_sub,
                    room: req.body.thu_p3_teach,
                    time: req.body.thu_p3_time,
                    duration: req.body.thu_p3_dur,
                },
                period_4: {
                    subject: req.body.thu_p4_sub,
                    room: req.body.thu_p4_teach,
                    time: req.body.thu_p4_time,
                    duration: req.body.thu_p4_dur,
                },
                period_5: {
                    subject: req.body.thu_p5_sub,
                    room: req.body.thu_p5_teach,
                    time: req.body.thu_p5_time,
                    duration: req.body.thu_p5_dur,
                },
                period_6: {
                    subject: req.body.thu_p6_sub,
                    room: req.body.thu_p6_teach,
                    time: req.body.thu_p6_time,
                    duration: req.body.thu_p6_dur,
                },
                period_7: {
                    subject: req.body.thu_p7_sub,
                    room: req.body.thu_p7_teach,
                    time: req.body.thu_p7_time,
                    duration: req.body.thu_p7_dur,
                },
                period_8: {
                    subject: req.body.thu_p8_sub,
                    room: req.body.thu_p8_teach,
                    time: req.body.thu_p8_time,
                    duration: req.body.thu_p8_dur,
                },
        
            },
            friday: {
                period_1: {
                    subject: req.body.fri_p1_sub,
                    room: req.body.fri_p1_teach,
                    time: req.body.fri_p1_time,
                    duration: req.body.fri_p1_dur,
                },
                period_2: {
                    subject: req.body.fri_p2_sub,
                    room: req.body.fri_p2_teach,
                    time: req.body.fri_p2_time,
                    duration: req.body.fri_p2_dur,
                },
                period_3: {
                    subject: req.body.fri_p3_sub,
                    room: req.body.fri_p3_teach,
                    time: req.body.fri_p3_time,
                    duration: req.body.fri_p3_dur,
                },
                period_4: {
                    subject: req.body.fri_p4_sub,
                    room: req.body.fri_p4_teach,
                    time: req.body.fri_p4_time,
                    duration: req.body.fri_p4_dur,
                },
                period_5: {
                    subject: req.body.fri_p5_sub,
                    room: req.body.fri_p5_teach,
                    time: req.body.fri_p5_time,
                    duration: req.body.fri_p5_dur,
                },
                period_6: {
                    subject: req.body.fri_p6_sub,
                    room: req.body.fri_p6_teach,
                    time: req.body.fri_p6_time,
                    duration: req.body.fri_p6_dur,
                },
                period_7: {
                    subject: req.body.fri_p7_sub,
                    room: req.body.fri_p7_teach,
                    time: req.body.fri_p7_time,
                    duration: req.body.fri_p7_dur,
                },
                period_8: {
                    subject: req.body.fri_p8_sub,
                    room: req.body.fri_p8_teach,
                    time: req.body.fri_p8_time,
                    duration: req.body.fri_p8_dur,
                },
        
            },
            saturady: {
                period_1: {
                    subject: req.body.sat_p1_sub,
                    room: req.body.sat_p1_teach,
                    time: req.body.sat_p1_time,
                    duration: req.body.sat_p1_dur,
                },
                period_2: {
                    subject: req.body.sat_p2_sub,
                    room: req.body.sat_p2_teach,
                    time: req.body.sat_p2_time,
                    duration: req.body.sat_p2_dur,
                },
                period_3: {
                    subject: req.body.sat_p3_sub,
                    room: req.body.sat_p3_teach,
                    time: req.body.sat_p3_time,
                    duration: req.body.fri_p3_dur,
                },
                period_4: {
                    subject: req.body.sat_p4_sub,
                    room: req.body.sat_p4_teach,
                    time: req.body.sat_p4_time,
                    duration: req.body.sat_p4_dur,
                },
                period_5: {
                    subject: req.body.sat_p5_sub,
                    room: req.body.sat_p5_teach,
                    time: req.body.sat_p5_time,
                    duration: req.body.sat_p5_dur,
                },
                period_6: {
                    subject: req.body.sat_p6_sub,
                    room: req.body.sat_p6_teach,
                    time: req.body.sat_p6_time,
                    duration: req.body.sat_p6_dur,
                },
                period_7: {
                    subject: req.body.sat_p7_sub,
                    room: req.body.sat_p7_teach,
                    time: req.body.sat_p7_time,
                    duration: req.body.sat_p7_dur,
                },
                period_8: {
                    subject: req.body.sat_p8_sub,
                    room: req.body.sat_p8_teach,
                    time: req.body.sat_p8_time,
                    duration: req.body.sat_p8_dur,
                },
        
            }
        }
    );
    routine.save(function (err) {
        if (err) return next(err);
        res.send('Teachers Routine Added Successfully For id-'+req.body._id);
    })
}

exports.student_routine_details = function (req, res, next) {
    StudentRoutine.findById(req.params.id, function (err, routine) {
        if (err) return next(err);
        res.send(routine);
    })
};

exports.teacher_routine_details = function (req, res, next) {
    TeacherRoutine.findById(req.params.id, function (err, routine) {
        if (err) return next(err);
        res.send(routine);
    })
};

exports.student_routine_delete = function (req, res, next) {
    StudentRoutine.findByIdAndRemove(req.params.id, function (err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};

exports.teacher_routine_delete = function (req, res, next) {
    TeacherRoutine.findByIdAndRemove(req.params.id, function (err) {
        if (err) return next(err);
        res.send('Deleted successfully!');
    })
};