var Post = require('../models/post');
var dotenv = require("dotenv");
var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");


exports.post_coverImage = async function (req, res, next) {
  console.log(req.params.id);
  Post.findOneAndUpdate(
        { _id: req.params.id },
        {
            $set: {
                coverImage: req.file.path,
            },
        },
        { new: true },
        (err, result) => {
            if (err) return res.json(err);
            return res.json(result);
        }
    );
};

exports.add_post = async function (req, res, next) {

  console.log(req.decoded.fullName);
    const post = Post({
        username: req.decoded.fullName,
      title: req.body.title,
      dept: req.body.dept,
        year: req.body.year,
    });
    post.save().then((result) => {
      res.json({ data: result["_id"] });
      console.log(result);
    })
        .catch((err) => {
            console.log(err), res.json({ err: err });
        });
};

exports.my_post = async function (req, res, next) {
    Post.find({ username: req.decoded.fullName }, (err, result) => {
        if (err) return res.json(err);
        return res.json({ data: result });
    });
};

exports.post_for_one = async function (req, res, next) {
  let saal = req.decoded.sem%2==0?req.decoded.sem/2:(req.decoded.sem+1)/2;
  var year;
  if (saal == 1) {
    year = saal.toString() + "ST";
  }
  else if (saal == 2) {
    year = saal.toString() + "ND";
  }
  else if (saal == 3) {
    year = saal.toString() + "RD";
  }
  else {
    year = saal.toString() + "TH";
  }
  //console.log("saal= "+year);
  Post.find({ dept: req.decoded.dept, year: year+"-YEAR" }, (err, result) => {
        if (err) return res.json(err);
        return res.json({ data: result });
    });
};

exports.other_post = async function (req, res, next) {
    Post.find({ username: { $ne: req.decoded.fullName } }, (err, result) => {
        if (err) return res.json(err);
        return res.json({ data: result });
      });
};

exports.delete_post = async function (req, res, next) {
    Post.findOneAndDelete(
        {
          $and: [{ username: req.decoded.username }, { _id: req.params.id }],
        },
        (err, result) => {
          if (err) return res.json(err);
          else if (result) {
            console.log(result);
            return res.json("Post deleted");
          }
          return res.json("Post not deleted");
        }
      );
};
