import 'dart:ui';
import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/Modals/super_receiver_chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentRecords extends StatefulWidget {
  const StudentRecords({Key key}) : super(key: key);

  @override
  _StudentRecordsState createState() => _StudentRecordsState();
}

class _StudentRecordsState extends State<StudentRecords> {
  Dio dio = Dio();
  SuperReceiverChatModel superReceiverChatModel = SuperReceiverChatModel();
  List<ReceiverChatModel> data = [];
  ReceiverChatModel sourceChat;
  String usertype;
  String name;
  String dept;
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
        dept = prefs.getString('dept');
        data = superReceiverChatModel.data;
        sourceChat = ReceiverChatModel(fullName: name, id: id);
      });
    }
  }

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June"
  ];
  List<String> exams = ["CA-1", "CA-2", "CA-3", "CA-4", "CA-5", "Semester"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Attandence",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 120,
                ),
                Text("percentage"),
              ],
            ),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: months.length,
                  itemBuilder: (context, index) => Attandence(
                        month: months[index],
                        percent: "80%",
                      )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Academics Grades",
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
                Text("Grades"),
              ],
            ),
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: exams.length,
                  itemBuilder: (context, index) => AcademicsGrades(
                      exams: exams[index], grades: "Excellent")),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Fees",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 160,
                ),
                Text("Amount"),
              ],
            ),
            children: [
              ListTile(
                leading: Text("Semester"),
                trailing: Text("Amount"),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {},
                child: Text("PAY"),
                color: Colors.blue,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            shadowColor: Colors.blueAccent,
            initiallyExpanded: true,
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "View Faculties",
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
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) => ViewFaculties(
                      name: data[index].fullName, id: data[index].id)),
            ],
          )
        ],
      ),
    );
  }
}

class AcademicsGrades extends StatelessWidget {
  const AcademicsGrades({Key key, this.exams, this.grades}) : super(key: key);
  final String exams;
  final String grades;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(exams),
      trailing: Text(grades),
    );
  }
}

class Attandence extends StatelessWidget {
  const Attandence({Key key, this.month, this.percent}) : super(key: key);
  final String month;
  final String percent;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(month),
      trailing: Text(percent),
    );
  }
}

class ViewFaculties extends StatelessWidget {
  const ViewFaculties({Key key, this.name, this.id}) : super(key: key);
  final String name;
  final int id;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        radius: 27,
      ),
      subtitle: Text(id.toString()),
      trailing: Text("CSE"),
    );
  }
}
