var express = require('express');
var router = express.Router();
const cleanBody = require("../middleware/cleanbody");
const {verify} = require("../middleware/authtoken");

// Require the controllers WHICH WE DID NOT CREATE YET!!
var student_controller = require('../controller/student');

router.post('/login',cleanBody, student_controller.login);

router.get('/details', cleanBody, verify, student_controller.student_details);

router.put('/change_password', cleanBody, verify, student_controller.student_change_password);

router.get('/my_teachers/:dept', cleanBody, verify, student_controller.my_teachers);

router.get('/routine/:id', cleanBody, verify, student_controller.routine_details);



module.exports = router;