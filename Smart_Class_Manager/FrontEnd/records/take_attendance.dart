import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/Modals/super_receiver_chat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key key, this.sem, this.dept}) : super(key: key);
  final String sem;
  final String dept;
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Dio dio = Dio();
  SuperReceiverChatModel superReceiverChatModel = SuperReceiverChatModel();
  List<ReceiverChatModel> data = [];
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
    var token = prefs.getString('logToken');
    var response = await dio.get(
        "https://scm007v2.herokuapp.com/teacher/my_students/${widget.dept}/${widget.sem}",
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("sem = ${widget.sem}");
    return data.length != null
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                  "Attendance Register (${widget.dept}/sem-${widget.sem})"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        attendanceCard(data[index].fullName, data[index].id),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {},
                  color: Colors.green.shade300,
                  child: Text("Submit"),
                )
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
  }

  attendanceCard(String name, int studentId) {
    bool check = false;
    return CheckboxListTile(
        title: Text(
          name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text("Roll- ${studentId.toString()}"),
        value: check,
        activeColor: Colors.blue,
        selected: check,
        onChanged: (bool newValue) {
          setState(() {
            check = newValue;
          });
        });
  }
}
