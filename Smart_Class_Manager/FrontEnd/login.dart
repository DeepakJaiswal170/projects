import 'package:flutter/material.dart';
import 'Modals/user_modal.dart';
import 'home_page.dart';
import 'package:group_button/group_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _idController = TextEditingController();
  var _passController = TextEditingController();
  bool showProgressloading = false;
  String userType = "";
  Dio dio = new Dio();
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future attemptLogin(int roll, String password, String usertype) async {
    print(roll);
    print(password);
    if (usertype == "") {
      displayDialog(context, "WARNING", "User Type Must Be Selected");
    } else {
      try {
        var resp = await dio.post(
            "https://scm007v2.herokuapp.com/$usertype/login",
            data: {"_id": roll, "password": password});
        if (resp.statusCode == 200) {
          var token = resp.data["data"]["token"];
          print(token);
          print("login successfull");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('logToken', token);
          prefs.setString('usertype', usertype);
          final response =
              await dio.get("https://scm007v2.herokuapp.com/$usertype/details",
                  options: Options(
                    headers: {"authorization": token},
                  ));
          User user = User();
          user = User.fromJson(response.data, token, usertype);
          prefs.setString('name', user.fullName);
          prefs.setInt('id', user.id);
          prefs.setString('dept', user.dept);
          prefs.setString('mail', user.mail);
          prefs.setInt('sem', user.sem);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          
        }
      } on DioError catch (e) {
        if (e.response.statusCode == 404) {
          displayDialog(context, "USER NOT FOUND",
              "Please Check Your ID Number And Try Again");
        } else if (e.response.statusCode == 400) {
          displayDialog(context, "INVALID PASSWORD",
              "Please Check Your Password And Try Again");
        } else {
          displayDialog(context, "ERROR !!", "Something Went Wrong");
        }
      }
    }
  }

  void displayDialog(context, title, text) {
    setState(() {
      showProgressloading = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0
            )
          )
        ),
        title: Center(child: Text(title)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            SizedBox(
              height: 20,
            ),
            Center(
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                 Navigator.of(context).pop();
                },
                color: Colors.green,
                child: Text("Okay"),
               ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.blue,
        body: ModalProgressHUD(
          inAsyncCall: showProgressloading,
          opacity: 0.5,
          color: Colors.white,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome!\n Enter Your Credentials Below\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              // Text("\n"),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    Flexible(
                      child: TextField(
                        showCursor: true,
                        controller: _idController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "ID Number",
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white54),
                          hintText: 'Enter your ID No.',
                          icon: Icon(Icons.person, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    Flexible(
                      child: TextField(
                        showCursor: true,
                        controller: _passController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white54),
                          icon: Icon(Icons.lock, color: Colors.white),
                          suffixIcon: IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: _isHidden,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: GroupButton(
                  isRadio: true,
                  spacing: 50,
                  onSelected: (index, isSelected) {
                    if (index == 0) {
                      userType = "student";
                    } else {
                      userType = "teacher";
                    }
                    print('$index button is selected');
                  },
                  buttons: ["Student", "Teacher"],
                  buttonHeight: 30,
                  buttonWidth: 90,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Container(
                  width: screenSize.width * 0.5,
                  height: screenSize.width * 0.12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Color(0xFF5DCCC2),
                        onPressed: () async {
                          var roll = int.parse(_idController.text);
                          var password = _passController.text;
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            showProgressloading =
                                true; // then login button is pressed the circular flutter indicator will get active
                          });
                          attemptLogin(roll, password, userType);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                  )),
            ],
          )),
        ));
  }
}
