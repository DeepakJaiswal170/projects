import 'dart:ui';
import 'package:api_check/records/take_attendance.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'grades.dart';

class TeacherRecords extends StatefulWidget {
  const TeacherRecords({Key key, this.dept}) : super(key: key);
  final String dept;
  @override
  _TeacherRecordsState createState() => _TeacherRecordsState();
}

class _TeacherRecordsState extends State<TeacherRecords> {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June"
  ];

  // var _chosenYear;
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
              "Your Attandence",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 80,
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
                        percent: "97%",
                      )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            shadowColor: Colors.blueAccent,
            initiallyExpanded: false,
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Upload Grades",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Text(widget.dept),
              ],
            ),
            children: [
              gradetile("1st Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("2nd Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("3rd Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("4th Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("5th Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("6th Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("7th Semester"),
              SizedBox(
                height: 5,
              ),
              gradetile("8th Semester"),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTileCard(
            shadowColor: Colors.blueAccent,
            initiallyExpanded: false,
            baseColor: Colors.blue,
            // key:,
            leading: Text(
              "Take Attandence",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(""),
            subtitle: Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                Text(widget.dept),
              ],
            ),
            children: [
              attendancetile("1st Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("2nd Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("3rd Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("4th Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("5th Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("6th Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("7th Semester"),
              SizedBox(
                height: 5,
              ),
              attendancetile("8th Semester"),
              SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }

  attendancetile(String s) {
    return ListTile(
        tileColor: Colors.lightBlueAccent,
        title: Text(s),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AttendancePage(
                      sem: s.substring(0, 1), dept: widget.dept
                    )),
          );
        });
  }

  gradetile(String s) {
    return ListTile(
        tileColor: Colors.lightBlueAccent,
        title: Text(s),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Gradepage(
                      sem: s.substring(0, 1), dept: widget.dept
                    )),
          );
        });
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

class TakeAttandence extends StatelessWidget {
  const TakeAttandence({Key key, this.name, this.id, this.value})
      : super(key: key);
  final String name;
  final int id;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Row(children: [
          Text(name.length > 14 ? name.substring(0, 14) + "..." : name),
          Text(" (" + id.toString() + " )")
        ]),
        value: value,
        activeColor: Colors.blue,
        onChanged: (bool newValue) {});
  }
}

class UploadGrades extends StatelessWidget {
  const UploadGrades({Key key, this.name, this.id}) : super(key: key);
  final String name;
  final int id;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
      ),
      title: Text(name),
      subtitle: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        maxLines: 1,
        maxLength: 1,
      ),
    );
  }
}
