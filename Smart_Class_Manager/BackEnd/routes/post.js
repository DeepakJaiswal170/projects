var express = require('express');
var router = express.Router();
const multer = require("multer");
const path = require("path");
const cleanBody = require("../middleware/cleanbody");
const {verify} = require("../middleware/authtoken");

// Require the controllers WHICH WE DID NOT CREATE YET!!
var post_controller = require('../controller/post');


const storage = multer.diskStorage({
    destination: './upload',
    filename: (req, file, cb) => {
      cb(null, req.params.id + ".jpg")
    },
  });
  
  const upload = multer({
    storage: storage,
    limits: {
      fileSize: 1024 * 1024 * 6,
    },
  });

router.patch('/add_image/:id', verify, upload.single('img'), post_controller.post_coverImage);  

router.post('/add_post', cleanBody, verify, post_controller.add_post);

router.get('/my_post', cleanBody, verify, post_controller.my_post);

router.get('/for_student', cleanBody, verify, post_controller.post_for_one);

router.get('/other_post', cleanBody, verify, post_controller.other_post);

router.delete('/delete_post/:id', cleanBody, verify, post_controller.delete_post);

module.exports = router;