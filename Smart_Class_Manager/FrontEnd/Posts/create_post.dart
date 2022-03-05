import 'dart:io';
import 'package:api_check/Modals/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Dio dio = Dio();
  TextEditingController postText = TextEditingController();
  String _chosenDept;
  String _chosenYear;
  ImagePicker _picker = ImagePicker();
  File _image;
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Create Post"),
              backgroundColor: Colors.blueAccent,
            ),
            body: circular
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      Divider(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<String>(
                            dropdownColor: Colors.blue,
                            focusColor: Colors.blue,
                            value: _chosenDept,
                            style: TextStyle(color: Colors.blueAccent),
                            iconEnabledColor: Colors.black,
                            items: <String>[
                              'ALL',
                              'CSE',
                              'ECE',
                              'EEE',
                              'CE',
                              'ME',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Department",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _chosenDept = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          DropdownButton<String>(
                            dropdownColor: Colors.blue,
                            focusColor: Colors.blue,
                            value: _chosenYear,
                            //elevation: 5,
                            style: TextStyle(color: Colors.blueAccent),
                            iconEnabledColor: Colors.black,
                            items: <String>[
                              'ALL',
                              '1st-YEAR',
                              '2nd-YEAR',
                              '3rd-YEAR',
                              '4TH-YEAR',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Academic Year",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _chosenYear = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              showCursor: true,
                              controller: postText,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Required Field";
                              },
                              maxLines: null,
                              decoration: InputDecoration(
                            hintText: "Write Your Post here!",
                            border: OutlineInputBorder(),
                          ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      imageprofile(context),
                      SizedBox(
                        height: 64.0,
                      ),
                      // ignore: deprecated_member_use
                      Container(
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Color(0xFF5DCCC2),
                                  onPressed: () async {
                                    final FormState form = _formKey.currentState;
                                    if (form.validate()) {
                                      setState(() {
                                        circular = true;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      var token = prefs.getString('logToken');
                                      Post post = Post(
                                          title: postText.text,
                                          dept: _chosenDept != null
                                              ? _chosenDept
                                              : "ALL",
                                          year: _chosenYear != null
                                              ? _chosenYear
                                              : "ALL");
                                      //print(post.toJson());
                                      var response = await dio.post(
                                          "https://scm007v2.herokuapp.com/post/add_post",
                                          data: post.toJson(),
                                          options: Options(
                                            headers: {"authorization": token},
                                          ));
                                      print(response.statusCode);
                                      if ((response.statusCode == 200 ||
                                              response.statusCode == 201) &&
                                          _image != null) {
                                        String id = response.data["data"];
                                        String fileName =
                                            _image.path.split('/').last;
                                        FormData formData = FormData.fromMap({
                                          "img": await MultipartFile.fromFile(
                                              _image.path,
                                              filename: fileName),
                                        });
                                        var imageResponse = await dio.patch(
                                            "https://scm007v2.herokuapp.com/post/add_image/$id",
                                            data: formData,
                                            options: Options(
                                              headers: {"authorization": token},
                                            ));
                                        print(imageResponse.statusCode);
                                        if (imageResponse.statusCode == 200 ||
                                            imageResponse.statusCode == 201) {
                                          Navigator.pop(context);
                                        }
                                      } else if (_image == null) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'POST NOW',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )),
                    ],
                  ),
          );
        });
  }

  Widget imageprofile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 270.0,
              width: 270.0,
              color: Colors.grey,
              child: _image != null
                  ? Image.file(_image, fit: BoxFit.fitWidth)
                  : Icon(Icons.image, color: Colors.white, size: 50.0),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet(context)),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 35.0,
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _image = null;
                });
              },
              child: Icon(
                Icons.cancel_outlined,
                color: _image != null ? Colors.red : Colors.transparent,
                size: 35.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose an Image",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                ),
                onPressed: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(
                  Icons.image,
                ),
                onPressed: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  _imgFromCamera() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
}
