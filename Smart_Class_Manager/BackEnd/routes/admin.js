var express = require('express');
var router = express.Router();
const cleanBody = require("../middleware/cleanbody")

// Require the controllers WHICH WE DID NOT CREATE YET!!
var admin_controller = require('../controller/admin');


//STUDENT
router.post('/student/create', cleanBody, admin_controller.student_create);

router.get('/student/:id', cleanBody, admin_controller.student_details);

router.get('/student/all/:dept', cleanBody, admin_controller.student_view_all);

router.put('/student/change_password', cleanBody, admin_controller.student_change_password);

router.put('/student/:id/update', cleanBody, admin_controller.student_update);

router.delete('/student/:id/delete', cleanBody, admin_controller.student_delete);

//TEACHER
router.post('/teacher/create', cleanBody, admin_controller.teacher_create);

router.get('/teacher/:id', cleanBody, admin_controller.teacher_details);

router.get('/teacher/all/:dept', cleanBody, admin_controller.teacher_view_all);

router.put('/teacher/change_password', cleanBody, admin_controller.teacher_change_password);

router.put('/teacher/:id/update', cleanBody, admin_controller.teacher_update);

router.delete('/teacher/:id/delete', cleanBody, admin_controller.teacher_delete);

//ROUTINE
router.post('/routine/teacher/create', cleanBody, admin_controller.create_teacher_routine);

router.post('/routine/student/create', cleanBody, admin_controller.create_student_routine);

router.get('/routine/student/:id', cleanBody, admin_controller.student_routine_details);

router.get('/routine/teacher/:id', cleanBody, admin_controller.teacher_routine_details);

router.delete('/routine/student/delete/:id', cleanBody, admin_controller.student_routine_delete);

router.delete('/routine/teacher/delete/:id', cleanBody, admin_controller.student_routine_delete);


module.exports = router;