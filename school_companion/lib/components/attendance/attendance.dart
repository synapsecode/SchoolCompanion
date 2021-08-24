import 'package:flutter/material.dart';

Widget rowItem(
    {String left,
    String right,
    Color leftColor = Colors.white54,
    Color rightColor = Colors.blue,
    alignment = MainAxisAlignment.spaceBetween,
    double fontSize = 20.0}) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: alignment,
        children: <Widget>[
          Text("$left: ",
              style: TextStyle(fontSize: fontSize, color: leftColor)),
          Text(right, style: TextStyle(fontSize: fontSize, color: rightColor))
        ],
      ),
      SizedBox(
        height: 5.0,
      ),
    ],
  );
}

class AttendanceView extends StatelessWidget {
  final Map<String, dynamic> a;
  AttendanceView(this.a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.black87,
        child: Attendance(a),
      ),
    ));
  }
}

class Attendance extends StatelessWidget {
  final Map<String, dynamic> a;
  Attendance(this.a);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TopSection(a['year']),
              Divider(
                color: Colors.white70,
              ),
              StudentInfoPanel(
                studentName: a['student_name'],
                grade: a['grade'],
                section: a['section'],
              ),
              Divider(
                color: Colors.white70,
              ),
              AttendanceObject(
                totalDays: a['total_days'],
                presentDays: a['present_days'],
                absentDays: a['absent_days'],
              ),
              Divider(
                color: Colors.white70,
              ),
              Summary(
            percentage: a['attendance_percentage'],
            status: a['status'] == "P" ? "GOOD" : "BAD",
          ),
          Divider(
            color: Colors.white70,
          ),
            ]),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  final String year;
  TopSection(this.year);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text("Attendance", style: TextStyle(fontSize: 60.0)),
        SizedBox(
          height: 10.0,
        ),
        rowItem(
            left: "Academic Year",
            right: year,
            fontSize: 22.0,
            alignment: MainAxisAlignment.start),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}

class StudentInfoPanel extends StatelessWidget {
  final String studentName;
  final String grade;
  final String section;
  StudentInfoPanel({this.studentName, this.grade, this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Row(children: <Widget>[
          Icon(Icons.person),
          SizedBox(
            width: 20.0,
          ),
          Text("Student Information", style: TextStyle(fontSize: 25.0)),
          SizedBox(
            height: 10.0,
          )
        ]),
        SizedBox(
          height: 10.0,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              // color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  rowItem(left: "Name", right: studentName),
                  rowItem(
                      left: "Class",
                      right: double.parse(grade).toInt().toString()),
                  rowItem(left: "Section", right: section),
                ],
              ),
            ))
      ],
    );
  }
}

class AttendanceObject extends StatelessWidget {
  final String presentDays;
  final String absentDays;
  final String totalDays;
  AttendanceObject({this.presentDays, this.absentDays, this.totalDays});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Row(children: <Widget>[
          Icon(Icons.people),
          SizedBox(
            width: 20.0,
          ),
          Text("Attendance Data", style: TextStyle(fontSize: 25.0)),
          SizedBox(
            height: 10.0,
          )
        ]),
        SizedBox(
          height: 10.0,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              // color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  rowItem(
                      left: "Total Days",
                      right: double.parse(totalDays).toInt().toString()),
                  rowItem(
                      left: "Present Days",
                      right: double.parse(presentDays).toInt().toString()),
                  rowItem(
                      left: "Absent Days",
                      right: double.parse(absentDays).toInt().toString()),
                ],
              ),
            ))
      ],
    );
  }
}

class Summary extends StatelessWidget {
  final String percentage;
  final String status;
  Summary({this.percentage, this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Row(children: <Widget>[
          Icon(Icons.bubble_chart),
          SizedBox(
            width: 20.0,
          ),
          Text("Summary", style: TextStyle(fontSize: 25.0)),
          SizedBox(
            height: 10.0,
          )
        ]),
        SizedBox(
          height: 10.0,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              // color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  rowItem(
                      left: "Attendance Percentage",
                      right: double.parse(percentage).toStringAsFixed(2),
                      fontSize:18.0),
                  rowItem(
                      left: "Status",
                      right: status,
                      rightColor: status == "GOOD" ? Colors.green : Colors.red),
                ],
              ),
            ))
      ],
    );
  }
}