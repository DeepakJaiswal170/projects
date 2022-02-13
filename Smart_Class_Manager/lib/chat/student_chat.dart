import 'package:api_check/CustomUI/CustomCard.dart';
import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/Modals/super_receiver_chat_model.dart';
import 'package:api_check/chat/SelectContact.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentChatList extends StatefulWidget {
  StudentChatList({Key key}) : super(key: key);
  @override
  _StudentChatListState createState() => _StudentChatListState();
}

class _StudentChatListState extends State<StudentChatList> {
  Dio dio = Dio();
  SuperReceiverChatModel superReceiverChatModel = SuperReceiverChatModel();
  List<ReceiverChatModel> data = [];
  ReceiverChatModel sourceChat;
  String usertype;
  String name;
  String _chosenYear;
  int id;
  String sem = '8';
  var dept;
  var token;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('logToken');
    var dept = prefs.getString("dept");
    var response = await dio.get(
        "https://scm007v2.herokuapp.com/teacher/my_students/$dept/$sem",
        options: Options(
          headers: {"authorization": token},
        ));
    superReceiverChatModel = SuperReceiverChatModel.fromJson(response.data);
    if (mounted) {
      setState(() {
        usertype = prefs.getString('usertype');
        name = prefs.getString('name');
        id = prefs.getInt('id');
        data = superReceiverChatModel.data;
        sourceChat = ReceiverChatModel(
          fullName: name,
          id: id,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    // data.length != null
    //     ? 
        Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builde) => SelectContact(
                              contacts: data,
                            )));
              },
              child: Icon(Icons.chat),
            ),
            body: Column(
              children: [
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  focusColor: Colors.blue,
                  value: _chosenYear,
                  //elevation: 5,
                  style: TextStyle(color: Colors.blueAccent),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    '1st-Semester',
                    '2nd-Semester',
                    '3rd-Semester',
                    '4th-Semester',
                    '5th-Semester',
                    '6th-Semester',
                    '7th-Semester',
                    '8th-Semester',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
                  onChanged: (String value) async {
                    
                    // var response = await dio.get(
                    //     "https://scm007v2.herokuapp.com/teacher/my_students/$dept/$sem",
                    //     options: Options(
                    //       headers: {"authorization": token},
                    //     ));
                    // superReceiverChatModel =
                    //     SuperReceiverChatModel.fromJson(response.data);
                    setState(() {
                      sem = value.substring(0, 1);
                      _chosenYear = value;
                      // data = superReceiverChatModel.data;
                    });
                    getData();
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => CustomCard(
                      chatModel: data[index],
                      sourchat: sourceChat,
                    ),
                  ),
                ),
              ],
            ),
          );
      
    // : Container(
    //   child: Center(
    //       child: CircularProgressIndicator(
    //         backgroundColor: Colors.white,
    //       ),
    //     ),
    // );
  }
}
