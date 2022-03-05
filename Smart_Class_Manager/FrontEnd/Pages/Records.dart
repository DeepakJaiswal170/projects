import 'package:api_check/records/StudentRecords.dart';
import 'package:api_check/records/TeachersRecords.dart';
import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  Records({Key key, this.dept, this.usertype}) : super(key: key);
  final String dept;
  final String usertype;
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Records"),
        ),
        body: widget.usertype == "student" ? StudentRecords() : TeacherRecords(dept: widget.dept,));
  }
}
