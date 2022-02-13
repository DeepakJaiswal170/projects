

class TeacherTimetable {
  Period1 period1;
  Period1 period2;
  Period1 period3;
  Period1 period4;
  Period1 period5;
  Period1 period6;
  Period1 period7;
  Period1 period8;

  TeacherTimetable(
      {this.period1,
      this.period2,
      this.period3,
      this.period4,
      this.period5,
      this.period6,
      this.period7,
      this.period8});

  TeacherTimetable.fromJson(Map<String, dynamic> json) {
    period1 = json['period_1'] != null
        ? new Period1.fromJson(json['period_1'])
        : null;
    period2 = json['period_2'] != null
        ? new Period1.fromJson(json['period_2'])
        : null;
    period3 = json['period_3'] != null
        ? new Period1.fromJson(json['period_3'])
        : null;
    period4 = json['period_4'] != null
        ? new Period1.fromJson(json['period_4'])
        : null;
    period5 = json['period_5'] != null
        ? new Period1.fromJson(json['period_5'])
        : null;
    period6 = json['period_6'] != null
        ? new Period1.fromJson(json['period_6'])
        : null;
    period7 = json['period_7'] != null
        ? new Period1.fromJson(json['period_7'])
        : null;
    period8 = json['period_8'] != null
        ? new Period1.fromJson(json['period_8'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.period1 != null) {
      data['period_1'] = this.period1.toJson();
    }
    if (this.period2 != null) {
      data['period_2'] = this.period2.toJson();
    }
    if (this.period3 != null) {
      data['period_3'] = this.period3.toJson();
    }
    if (this.period4 != null) {
      data['period_4'] = this.period4.toJson();
    }
    if (this.period5 != null) {
      data['period_5'] = this.period5.toJson();
    }
    if (this.period6 != null) {
      data['period_6'] = this.period6.toJson();
    }
    if (this.period7 != null) {
      data['period_7'] = this.period7.toJson();
    }
    if (this.period8 != null) {
      data['period_8'] = this.period8.toJson();
    }
    return data;
  }
}

class Period1 {
  String subject;
  String room;
  String time;
  int duration;

  Period1({this.subject, this.room, this.time, this.duration});

  Period1.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    room = json['room'];
    time = json['time'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['room'] = this.room;
    data['time'] = this.time;
    data['duration'] = this.duration;
    return data;
  }
}
