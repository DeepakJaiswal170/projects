import 'package:api_check/Modals/teacher_routine_model.dart';

import 'package:flutter/material.dart';

class TeacherRoutineCard extends StatelessWidget {
  TeacherRoutineCard({Key key, this.timetable}) : super(key: key);
  final TeacherTimetable timetable;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period1.subject, timetable.period1.room,
            timetable.period1.time, timetable.period1.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period2.subject, timetable.period2.room,
            timetable.period2.time, timetable.period2.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period3.subject, timetable.period3.room,
            timetable.period3.time, timetable.period3.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period4.subject, timetable.period4.room,
            timetable.period4.time, timetable.period4.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period5.subject, timetable.period5.room,
            timetable.period5.time, timetable.period5.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period6.subject, timetable.period6.room,
            timetable.period6.time, timetable.period6.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period7.subject, timetable.period7.room,
            timetable.period7.time, timetable.period7.duration),
        SizedBox(
          height: 10,
        ),
        eachCard(timetable.period8.subject, timetable.period8.room,
                timetable.period8.time, timetable.period8.duration),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

Widget eachCard(String subject, String room, String time, int duration) {
  return Card(
    color: Colors.grey,
    margin: EdgeInsets.only(top: 5, bottom: 15, left: 3, right: 3),
    elevation: 5.0,
    child: Container(
      height: 120,
      child: ListTile(
        leading: Icon(Icons.book),
        title: Text(
          subject,
          textScaleFactor: 1.8,
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black,
              height: 10,
            ),
            Row(
              children: [
                Icon(Icons.room),
                SizedBox(
                  width: 5,
                ),
                Text(
                  room,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  time,
                  //textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 17,
                ),
                Text(
                  "${duration.toString()} mins",
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 10,
            ),
          ],
        ),
      ),
    ),
  );
}
