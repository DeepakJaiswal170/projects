var Teacher = require('../models/teacher');
var Student = require('../models/student');
var Routine = require('../models/teacher_routine');
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
    const teacher = await Teacher.findOne({ _id: _id });

    // NOT FOUND - Throw error
    if (!teacher) {
      return res.status(404).json({
        error: true,
        message: "Invalid Student ID",
      });
    }

    //2. Verify the password is valid
    const validPassword = await bcrypt.compare(req.body.password, teacher.password);
    if (!validPassword) {
      return res.status(400).json({
        error: true,
        message: "Invalid Password",
      });
    }
    console.log(teacher.fullName)
    // create token
    const token = jwt.sign(
      // payload data
      {
        _id: teacher._id,
        fullName: teacher.fullName,
      },
      process.env.TOKEN_SECRET
    );

    await teacher.save();
    return res.status(200).json({
      status: "success", message: "user found!!",
      data: {
        token: token
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

exports.teacher_details = function (req, res, next) {
  let accessToken = req.headers['authorization'];
  try {
    let payload = jwt.verify(accessToken, process.env.TOKEN_SECRET);

    Teacher.findById(payload._id, function (err, teacher) {
      // if (err) return next(err);

      res.send(teacher);
    })
  }
  catch (e) {
    //if an error occured return request unauthorized error
    return res.sendStatus(401);
  }
};

exports.teacher_change_password = async function (req, res, next) {
  const salt = await bcrypt.genSalt(10);
  const password = await bcrypt.hash(req.body.password, salt);
  await Teacher.updateOne(
    { "_id": req.decoded._id },
    { $set: { "password": password } },
    res.send('Password Updated')
  );
};

exports.my_students = function (req, res, next) {
  Student.find({ dept: req.params.dept, sem: req.params.sem }, (err, result) => {
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



