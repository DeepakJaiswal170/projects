import 'package:api_check/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Dio dio = Dio();
  bool circular = true;
  String usertype;
  String token;
  String name;
  int id;
  String dept;
  int sem;
  String mail;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usertype = prefs.getString('usertype');
      token = prefs.getString('logToken');
      name = prefs.getString('name');
      id = prefs.getInt('id');
      dept = prefs.getString('dept');
      sem = prefs.getInt('sem');
      mail = prefs.getString('mail');
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(mail);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profile"),
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.white,
        body: circular
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ))
            : ListView(
                children: <Widget>[
                  head(usertype),
                  nametextfield(name),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (sem != null) Semestertextfield(sem),
                  if (sem != null)
                    SizedBox(
                      height: 10.0,
                    ),
                  Departmenttextfield(dept),
                  SizedBox(
                    height: 10.0,
                  ),
                  idofuser(id),
                  SizedBox(
                    height: 10.0,
                  ),
                  mailidtextfield(mail),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 05, right: 05),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                              minWidth:
                                  MediaQuery.of(context).size.width / 2 - 10,
                              color: Colors.blue,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      TextEditingController _newPass1 =
                                          TextEditingController();
                                      TextEditingController _newPass2 =
                                          TextEditingController();
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        content: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                obscureText: true,
                                                showCursor: true,
                                                controller: _newPass1,
                                                validator: (value) {
                                                  return value.isNotEmpty
                                                      ? null
                                                      : "Required Field";
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "New Password",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  hintText:
                                                      'Enter your new password',
                                                  icon: Icon(Icons.lock,
                                                      color: Colors.black),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),

                                              TextFormField(
                                                controller: _newPass2,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Required Field";
                                                  } else if (value !=
                                                      _newPass1.text) {
                                                    print(value);
                                                    print(_newPass1);
                                                    return "Password does not match";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: "Confirm Password",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  hintText:
                                                      'Confirm your password',
                                                  icon: Icon(Icons.lock,
                                                      color: Colors.black),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.blue),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              // ignore: deprecated_member_use
                                              RaisedButton(
                                                onPressed: () async {
                                                  final FormState form =
                                                      _formKey.currentState;
                                                  if (form.validate()) {
                                                    // Navigator.of(context).pop();
                                                    // Center(
                                                    //     child:
                                                    //         CircularProgressIndicator(
                                                    //   backgroundColor: Colors.white,
                                                    // ));
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    var resp = await dio.put(
                                                        "https://scm007v2.herokuapp.com/$usertype/change_password",
                                                        data: {
                                                          "password":
                                                              _newPass1.text
                                                        },
                                                        options: Options(
                                                          headers: {
                                                            "authorization":
                                                                token
                                                          },
                                                        ));
                                                    if (resp.statusCode ==
                                                            200 ||
                                                        resp.statusCode ==
                                                            201) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      displayDialog(
                                                          context,
                                                          "Success",
                                                          "Password changed successfully");
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      displayDialog(
                                                          context,
                                                          "Error",
                                                          "Something went wrong");
                                                    }
                                                    print(resp.statusCode);
                                                  }
                                                },
                                                color: Colors.green,
                                                child: Text("Confirm"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: Text('Change Password'),
                                      );
                                    });
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                              minWidth:
                                  MediaQuery.of(context).size.width / 2 - 10,
                              color: Colors.blue,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    title: Center(child: Text("LOGOUT")),
                                    content: Text(
                                        "Are you sure you want to logout ?"),
                                    actions: <Widget>[
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.clear();
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                          );
                                        },
                                        color: Colors.blue,
                                        child: Text("YES"),
                                      ),
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: Colors.blue,
                                        child: Text("NO"),
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }

  Widget nametextfield(String name) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Name: " + name,
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Semestertextfield(int sem) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(
          Icons.class_,
          color: Colors.green,
        ),
        labelText: "Semester: " + sem.toString() + "th",
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Departmenttextfield(String dept) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: Icon(
          Icons.class__outlined,
          color: Colors.green,
        ),
        labelText: "Department: " + dept,
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Widget idofuser(int id) {
    String label = usertype == "student" ? "Roll No" : "Teacher ID";
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        prefixIcon: Icon(
          Icons.dock,
          color: Colors.green,
        ),
        labelText: "$label: " + id.toString(),
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Widget mailidtextfield(String mail) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.green,
        ),
        labelText: "Mail: " + mail,
        labelStyle: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Widget head(String usertype) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              //backgroundColor: ,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              "[$usertype]",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  void displayDialog(context, title, text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
}
