import 'package:flutter/material.dart';
import 'package:school_companion/components/notes/topicslist.dart';
import 'package:school_companion/datastore.dart' as datastore;

class Subjects {
  int id;
  String subject;
  String returnSubject;
  Subjects(this.id, this.subject, this.returnSubject);

  static List<Subjects> getYears() {
    return <Subjects>[
      Subjects(1, "Physics", "PHY"),
      Subjects(2, "Chemistry", "CHEM"),
      Subjects(3, "Mathematics", "MAT"),
      Subjects(4, "Biology", "BIO"),
      Subjects(5, "History & Civics", "HIS"),
      Subjects(6, "Geography", "GEO"),
      Subjects(7, "English 1", "ENG1"),
      Subjects(8, "English 2", "ENG2"),
      Subjects(9, "Second Language", "LNG"),
      Subjects(10, "Computer Applications", "COMP"),
      Subjects(11, "Physical Education", "PE"),
    ];
  }
}

class NotesDataForm extends StatefulWidget {
  _NotesDataFormState createState() => _NotesDataFormState();
}

class _NotesDataFormState extends State<NotesDataForm> {
  //Academic Years
  List<Subjects> _subjects = Subjects.getYears();
  List<DropdownMenuItem<Subjects>> _subjectItems;
  Subjects _selectedSubject;

  @override
  void initState() {
    _subjectItems = buildSubjectsDropDownList(_subjects);
    _selectedSubject = _subjectItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Subjects>> buildSubjectsDropDownList(List subjects) {
    List<DropdownMenuItem<Subjects>> items = List();
    for (Subjects subject in subjects) {
      items.add(
        DropdownMenuItem(
          value: subject,
          child: Text(subject.subject),
        ),
      );
    }
    return items;
  }

  onYearChange(Subjects selectedSubjects) {
    setState(() {
      _selectedSubject = selectedSubjects;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.import_contacts,
              size: 100.0,
            ),
            Text(
              "View Notes",
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 10.0),
            //Academic Year
            Container(
              width: 200.0,
              child: DropdownButton(
                isExpanded: true,
                value: _selectedSubject,
                items: _subjectItems,
                onChanged: onYearChange,
              ),
            ),
            Container(
              width: 200.0,
              child: RaisedButton(
                onPressed: () =>
                    _submit(context, _selectedSubject.returnSubject),
                child: Text("Submit"),
                color: Colors.black12,
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

void _submit(BuildContext context, String subject) async {
  try {
    Map<String, dynamic> x =
        await datastore.getNotes(subject, datastore.getUserInfo()['grade']);
    if (x['response'].length > 0) {
      print(x);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => TopicsList(x['response'])));
    } else {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text("Notes Unavailable"),
                content: Container(
                    height: 100.0,
                    child: Center(
                      child: Text(
                          "The Institution has not uploaded any ${datastore.getSubject(subject)} Notes. We are sorry for the inconvenience."),
                    )),
              ));
    }
  } catch (e) {
    //Some Sort Of Error
    print(e);
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Unkown Error"),
              content: Container(
                  height: 70.0,
                  child: Center(
                    child: Text(
                        "An Unexpected Error Occrured while trying to process the Request. Sorry For the Inconvenience"),
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
    paint.color = Colors.blue.shade900;
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
    paint.color = Colors.black38; //Color.fromARGB(30, 255, 255, 255);
    canvas.drawPath(overlay, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
