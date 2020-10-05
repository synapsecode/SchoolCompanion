import 'package:flutter/material.dart';
import 'package:school_companion_app/components/attendance/attendance.dart';
import 'package:school_companion_app/datastore.dart' as datastore;

class AcademicYear {
  int id;
  String year;
  String returnYear;
  AcademicYear(this.id, this.year, this.returnYear);

  static List<AcademicYear> getYears() {
    return <AcademicYear>[
      AcademicYear(1, "2015 - 2016", "2015"),
      AcademicYear(2, "2016 - 2017", "2016"),
      AcademicYear(3, "2017 - 2018", "2017"),
      AcademicYear(4, "2018 - 2019", "2018"),
      AcademicYear(5, "2019 - 2020", "2019"),
    ];
  }
}

class AttendanceDataForm extends StatefulWidget {
  _AttendanceDataFormState createState() => _AttendanceDataFormState();
}

class _AttendanceDataFormState extends State<AttendanceDataForm> {
  //Academic Years
  List<AcademicYear> _academicYears = AcademicYear.getYears();
  List<DropdownMenuItem<AcademicYear>> _yearItems;
  AcademicYear _selectedyear;

  @override
  void initState() {
    //Academic Year
    _yearItems = buildAcademicYearDropDownList(_academicYears);
    _selectedyear = _yearItems[0].value;
    super.initState();
  }

  //Academic Year
  List<DropdownMenuItem<AcademicYear>> buildAcademicYearDropDownList(
      List years) {
    List<DropdownMenuItem<AcademicYear>> items = List();
    for (AcademicYear year in years) {
      items.add(
        DropdownMenuItem(
          value: year,
          child: Text(year.year),
        ),
      );
    }
    return items;
  }

  onYearChange(AcademicYear selectedAcademicYear) {
    setState(() {
      _selectedyear = selectedAcademicYear;
    });
  }

  //BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
      painter: BackgroundPainter(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.people,
              size: 100.0,
            ),
            Text(
              "Fetch Attendance",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 10.0),
            //Academic Year
            Container(
              width: 200.0,
              child: DropdownButton(
                isExpanded: true,
                value: _selectedyear,
                items: _yearItems,
                onChanged: onYearChange,
              ),
            ),
            Container(
              width: 200.0,
              child: RaisedButton(
                onPressed: () => _submit(context, _selectedyear.returnYear),
                child: Text("Submit"),
                color: Colors.blue.shade900,
              ),
            )
            // Text("Year: ${_selectedyear.returnYear}"),
            // Text("SEMESTER: ${_selectedTerm.semester}"),
          ],
        ),
      ),
    ));
  }
}

void _submit(BuildContext context, String year) async {
  try {
    Map<String, dynamic> x = await datastore.getAttendance(
        datastore.getUserInfo()['student_name'], year);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AttendanceView(x)));
  } catch (e) {
    //Some Sort Of Error
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Attendance Unavailable"),
              content: Container(
                  height: 80.0,
                  child: Center(
                    child: Text(
                        "The Institution has not uploaded the Attendance Data for the Academic Year $year. We are sorry for the inconvenience."),
                  )),
            ));
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    //Draw Main BackGround
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.black;
    canvas.drawPath(mainBackground, paint);
    //Draw Overlay Path
    Path overlay = Path();
    overlay.moveTo(width * 0.9, 0.0);
    overlay.quadraticBezierTo(width * .5, height * 0.1, 0, height * 0.85);
    overlay.lineTo(0, height);
    overlay.lineTo(width * 0.25, height);
    overlay.quadraticBezierTo(width * .5, height * 0.7, width, height * 0.6);
    overlay.lineTo(width, 0.0);
    overlay.close();
    paint.color = Color.fromARGB(30, 255, 255, 255);
    canvas.drawPath(overlay, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
