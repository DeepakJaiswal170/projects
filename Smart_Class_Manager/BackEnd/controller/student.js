var Student = require('../models/student');
var Teacher = require('../models/teacher');
var Routine = require('../models/student_routine');
var dotenv = require("dotenv");
var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");





exports.login = async (req, res) => {
  
    try {
      const { _id, password } = req.body;
      
      if (!_id || !password) {
        return res.status(400).json({
          error: true,
          message: "Enter All Feilds",
        });
      }
  
      //1. Find if any account with that email exists in DB
      const student = await Student.findOne({ _id: _id });
  
      // NOT FOUND - Throw error
      if (!student) {
        return res.status(404).json({
          error: true,
          message: "Invalid Student ID",
        });
      }
  
      //2. Verify the password is valid
      const validPassword = await bcrypt.compare(req.body.password, student.password);
      if (!validPassword) {
        return res.status(400).json({
          error: true,
          message: "Invalid Password",
        });
      }

          // create token
      const token = jwt.sign(
        // payload data
        {
          _id: student._id,
          dept: student.dept,
          sem: student.sem
        },
        process.env.TOKEN_SECRET
      );
      await student.save();
      return res.status(200).json({
        status: "success", message: "user found!!",
        data: {
          token: token,
        }
      });

    } catch (err) {
      console.error("Login error", err);
      return res.status(500).json({
        error: true,
        message: "Couldn't login. Please try again later.",
      });
    }
  };

exports.student_details = function (req, res, next) {
  let accessToken = req.headers['authorization'];
  try {
    let payload = jwt.verify(accessToken, process.env.TOKEN_SECRET);
    
    Student.findById(payload._id, function (err, student) {
      // if (err) return next(err);
      
      res.send(student);
    })
  }
  catch(e){
    //if an error occured return request unauthorized error
    return res.sendStatus(401);
}
};

exports.student_change_password = async function (req, res, next) {
  const salt = await bcrypt.genSalt(10);
  const password = await bcrypt.hash(req.body.password, salt);
  console.log(req.decoded._id);
  await Student.updateOne(
    { "_id": req.decoded._id },
    { $set: { "password": password } },
    res.send('Password Updated,')
   );
};

exports.my_teachers = function (req, res, next) {
  Teacher.find({ dept: req.params.dept, }, (err, result) => {
      if (err) return res.json(err);
      return res.json({ data: result });
  });
};

exports.routine_details = function (req, res, next) {
  Routine.findById(req.params.id, function (err, routine) {
      if (err) return next(err);
      res.send(routine);
  })
};


