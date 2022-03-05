const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const Post = Schema({
    username: {
        type: String,
    },
    title: {
        type: String,
        required: true,
    },
    coverImage: {
      type: String,
      default: "",
    },
    dept: {
      type: String,
      default: "ALL",
    },
    year: {
      type: String,
      default: "ALL",
      },
    created: {
        type: Date,
        default: Date.now
  }
});

module.exports = mongoose.model("Post", Post);