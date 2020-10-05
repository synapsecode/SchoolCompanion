import 'package:flutter/material.dart';
import 'package:school_companion_app/components/results/results.dart';
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

class AcademicTerm {
  int id;
  String semester;
  AcademicTerm(this.id, this.semester);

  static List<AcademicTerm> getTerms() {
    return <AcademicTerm>[
      AcademicTerm(1, "SEMESTER 1"),
      AcademicTerm(2, "SEMESTER 2"),
      AcademicTerm(3, "CONSOLIDATED"),
      AcademicTerm(4, "WEEKLY TEST 1"),
      AcademicTerm(5, "WEEKLY TEST 2"),
      AcademicTerm(6, "WEEKLY TEST 3"),
      AcademicTerm(7, "WEEKLY TEST 4"),
    ];
  }
}

class ResultDataForm extends StatefulWidget {
  _ResultDataFormState createState() => _ResultDataFormState();
}

class _ResultDataFormState extends State<ResultDataForm> {
  //Academic Years
  List<AcademicYear> _academicYears = AcademicYear.getYears();
  List<DropdownMenuItem<AcademicYear>> _yearItems;
  AcademicYear _selectedyear;
  //Academic Terms
  List<AcademicTerm> _academicTerms = AcademicTerm.getTerms();
  List<DropdownMenuItem<AcademicTerm>> _termItems;
  AcademicTerm _selectedTerm;

  @override
  void initState() {
    //Academic Year
    _yearItems = buildAcademicYearDropDownList(_academicYears);
    _selectedyear = _yearItems[0].value;
    //Academic Terms
    _termItems = buildAcademicTermDropDownList(_academicTerms);
    _selectedTerm = _termItems[0].value;
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

  //Academic Term
  List<DropdownMenuItem<AcademicTerm>> buildAcademicTermDropDownList(
      List terms) {
    List<DropdownMenuItem<AcademicTerm>> items = List();
    for (AcademicTerm term in terms) {
      items.add(
        DropdownMenuItem(
          value: term,
          child: Text(term.semester),
        ),
      );
    }
    return items;
  }

  onTermChange(AcademicTerm selectedAcademicTerm) {
    setState(() {
      _selectedTerm = selectedAcademicTerm;
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
              Icons.equalizer,
              size: 100.0,
            ),
            Text(
              "Fetch Results",
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
            //Academic Term
            Container(
              width: 200.0,
              child: DropdownButton(
                isExpanded: true,
                value: _selectedTerm,
                items: _termItems,
                onChanged: onTermChange,
              ),
            ),
            Container(
              width: 200.0,
              child: RaisedButton(
                onPressed: () => _submit(
                    context, _selectedTerm.semester, _selectedyear.returnYear),
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

void _submit(BuildContext context, String semester, String year) async {
  try {
    Map<String, dynamic> x = await datastore.getResults(
        datastore.getUserInfo()['student_name'], semester, year);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Results(x)));
  } catch (e) {
    //Some Sort Of Error
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Results Unavailable"),
              content: Container(
                  height: 80.0,
                  child: Center(
                    child: Text(
                        "The Institution has not uploaded the Results for ${semester.contains(" ") ? 'Semester ' + semester.split(" ")[1] : semester} of the Academic Year $year. We are sorry for the inconvenience."),
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
