const jwt = require('jsonwebtoken');

exports.verify = function (req, res, next) {
  console.log("been here");
    let token = req.headers['authorization'];
    if (token) {
        jwt.verify(token, process.env.TOKEN_SECRET, (err, decoded) => {
          if (err) {
            return res.json({
              status: false,
              msg: "token is invalid",
            });
          } else {
            req.decoded = decoded;
            
            next();
          }
        });
      } else {
        return res.json({
          status: false,
          msg: "Token is not provided",
        });
      }
    };