import 'package:api_check/Modals/student_routine_model.dart';
import 'package:api_check/Modals/teacher_routine_model.dart';
import 'package:api_check/Routine/student_routine_card.dart';
import 'package:api_check/Routine/teacher_routine-card.dart';
import 'package:flutter/material.dart';

class Classroom extends StatefulWidget {
  Classroom({Key key, this.data, this.usertype}) : super(key: key);
  final dynamic data;
  final String usertype;
  @override
  _ClassroomState createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Monday'),
                Tab(text: 'Tuesday'),
                Tab(text: 'Wednesday'),
                Tab(text: 'Thursday'),
                Tab(text: 'Friday'),
                Tab(text: 'Saturday')
              ],
            ),
            // automaticallyImplyLeading: false,
            title: Text("Classroom"),
            backgroundColor: Colors.blueAccent,
          ),
          body: widget.data != null
              ? TabBarView(
                  children: [
                    day("monday"),
                    day("tuesday"),
                    day("wednesday"),
                    day("thursday"),
                    day("friday"),
                    day("saturday")
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )),
    );
  }

  day(String s) {
    if (widget.usertype == "student") {
      StudentTimetable timetable;
      timetable = StudentTimetable.fromJson(widget.data[s]);
      return ListView(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: StudentRoutineCard(
              timetable: timetable,
            ),
          ),
          SizedBox(
            height: 0,
          ),
        ],
      );
    } else if (widget.usertype == "teacher") {
      TeacherTimetable timetable;
      timetable = TeacherTimetable.fromJson(widget.data[s]);
      return ListView(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: TeacherRoutineCard(
              timetable: timetable,
            ),
          ),
          SizedBox(
            height: 0,
          ),
        ],
      );
    }
  }
}
