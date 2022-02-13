import 'package:api_check/chat/student_chat.dart';
import 'package:api_check/chat/teacher_chat.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var usertype;
  var dept;
  var token;
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        usertype = prefs.getString('usertype');
        dept = prefs.getString('dept');
        token = prefs.getString('logToken');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: usertype != "student"
          ? StudentChatList()
          : TeacherChatList()
          
    );
  }

  // ignore: non_constant_identifier_names
  SemesterList() async {
    return ExpansionTileCard(
            shadowColor: Colors.blueAccent,
            initiallyExpanded: false,
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Take Attandence",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Text("Department"),
              ],
            ),
            children: [
              semestertile("1st Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("2nd Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("3rd Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("4th Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("5th Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("6th Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("7th Semester"),
              SizedBox(
                height: 5,
              ),
              semestertile("8th Semester"),
              SizedBox(
                height: 5,
              ),]);
  }

  semestertile(String s) {
    return ListTile(
        tileColor: Colors.lightBlueAccent,
        title: Text(s),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Container()),//(sem: s.substring(0,1),)),
          );
        });
  }
}

 
