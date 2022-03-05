var express = require('express');
var router = express.Router();
const cleanBody = require("../middleware/cleanbody");
const {verify} = require("../middleware/authtoken")


// Require the controllers WHICH WE DID NOT CREATE YET!!
var teacher_controller = require('../controller/teacher');

router.post('/login',cleanBody, teacher_controller.login);

router.get('/details', cleanBody, verify, teacher_controller.teacher_details);

router.put('/change_password', cleanBody, verify, teacher_controller.teacher_change_password);

router.get('/my_students/:dept/:sem', cleanBody, verify, teacher_controller.my_students);

router.get('/routine/:id', cleanBody, verify, teacher_controller.routine_details);


module.exports = router;