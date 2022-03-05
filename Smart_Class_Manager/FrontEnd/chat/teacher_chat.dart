import 'package:api_check/CustomUI/CustomCard.dart';
import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/Modals/super_receiver_chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SelectContact.dart';

class TeacherChatList extends StatefulWidget {
  TeacherChatList({Key key}) : super(key: key);

  @override
  _TeacherChatListState createState() => _TeacherChatListState();
}

class _TeacherChatListState extends State<TeacherChatList> {
  Dio dio = Dio();
  SuperReceiverChatModel superReceiverChatModel = SuperReceiverChatModel();
  List<ReceiverChatModel> data = [];
  ReceiverChatModel sourceChat;
  String usertype;
  String name;

  int id;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dept = prefs.getString('dept');
    var token = prefs.getString('logToken');
    var response = await dio.get(
        "https://scm007v2.herokuapp.com/student/my_teachers/$dept",
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
        sourceChat = ReceiverChatModel(fullName: name, id: id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return data.length != null
        ? Scaffold(
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
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => CustomCard(
                    chatModel: data[index],
                    sourchat: sourceChat,
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
  }
}
