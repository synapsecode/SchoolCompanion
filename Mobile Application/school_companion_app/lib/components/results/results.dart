import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final Map<String, dynamic> results;
  Results(this.results);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(color: Colors.black87, child: ResultBody(results))),
    );
  }
}

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

String convertName(String x) {
  String name = x.split(" ")[0].toLowerCase();
  return "${name[0].toUpperCase()}${name.replaceFirst(name[0], "")} ${x.split(" ")[1]}";
}

class ResultBody extends StatelessWidget {
  final Map<String, dynamic> r;
  ResultBody(this.r);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TopSection(
            term: r['term_name'],
            year: r['year'],
          ),
          Divider(
            color: Colors.white70,
          ),
          StudentInfoPanel(
            studentName: r['student_name'],
            grade: r['grade'],
            section: r['section'],
            rollNo: r['roll_no'],
          ),
          Divider(
            color: Colors.white70,
          ),
          IndividualMarksPanel(
            phy: r['physics'],
            chem: r['chemistry'],
            math: r['maths'],
            bio: r['biology'],
            his: r['hisciv'],
            geo: r['geography'],
            eng1: r['eng1'],
            eng2: r['eng2'],
            sl: r['sl'],
            comp: r['ca'],
            pe: r['pe'],
            arts: r['arts'],
          ),
          Divider(
            color: Colors.white70,
          ),
          Summary(
            percentage: r['percentage'],
            status: r['status'] == "P" ? "Pass" : "Fail",
          ),
          Divider(
            color: Colors.white70,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                title: new Text("Feature Unavailable"),
                                content: Container(
                                    height: 40.0,
                                    child: Center(
                                      child: Text(
                                          "This Feature Has not yet been officially released!"),
                                    )),
                              ));
                    },
                    child: Text("View Marks Card"),
                    color: Colors.blue.shade900,
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}

class TopSection extends StatelessWidget {
  final String year;
  final String term;
  TopSection({this.term, this.year});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text("Results", style: TextStyle(fontSize: 90.0)),
        SizedBox(
          height: 10.0,
        ),
        rowItem(
            left: "Academic Year",
            right: year,
            fontSize: 22.0,
            alignment: MainAxisAlignment.start),
        rowItem(
            left: "Academic Term",
            right: term,
            fontSize: 22.0,
            alignment: MainAxisAlignment.start),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}

class StudentInfoPanel extends StatelessWidget {
  final String studentName;
  final String grade;
  final String section;
  final String rollNo;
  StudentInfoPanel({this.studentName, this.grade, this.section, this.rollNo});

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
                  rowItem(
                      left: "RollNo",
                      right: double.parse(rollNo).toInt().toString()),
                ],
              ),
            ))
      ],
    );
  }
}

class IndividualMarksPanel extends StatelessWidget {
  final String phy;
  final String chem;
  final String math;
  final String bio;
  final String his;
  final String geo;
  final String eng1;
  final String eng2;
  final String sl;
  final String comp;
  final String pe;
  final String arts;

  IndividualMarksPanel(
      {this.phy,
      this.chem,
      this.math,
      this.bio,
      this.eng1,
      this.eng2,
      this.his,
      this.geo,
      this.comp,
      this.arts,
      this.pe,
      this.sl});

  Widget _electiveComponent(String comp, String pe, String arts) {
    Widget returnWidget;
    if (comp != "") {
      returnWidget = rowItem(left: "Computer Applications", right: comp);
    } else if (pe != "") {
      returnWidget = rowItem(left: "Physical Education", right: pe);
    } else if (arts != "") {
      returnWidget = rowItem(left: "Arts", right: arts);
    }
    return returnWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Row(children: <Widget>[
          Icon(Icons.equalizer),
          SizedBox(
            width: 20.0,
          ),
          Text("Individual Marks", style: TextStyle(fontSize: 25.0)),
          SizedBox(
            width: 10.0,
          ),
          Text("( 100 )",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white30,
              ))
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
                  rowItem(left: "Physics", right: phy),
                  rowItem(left: "Chemistry", right: chem),
                  rowItem(left: "Mathematics", right: math),
                  rowItem(left: "Biology", right: bio),
                  rowItem(left: "History & Civics", right: his),
                  rowItem(left: "Geography", right: geo),
                  rowItem(left: "English Grammar", right: eng1),
                  rowItem(left: "English Literature", right: eng2),
                  rowItem(left: "Second Language", right: sl),
                  _electiveComponent(comp, pe, arts)
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
                      left: "Final Percentage",
                      right: double.parse(percentage).toStringAsFixed(2)),
                  rowItem(
                      left: "Status",
                      right: status,
                      rightColor: status == "Pass" ? Colors.green : Colors.red),
                ],
              ),
            ))
      ],
    );
  }
}