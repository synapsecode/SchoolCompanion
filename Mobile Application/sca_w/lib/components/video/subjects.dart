import 'package:flutter/material.dart';
import 'package:school_companion_app/components/video/Topics.dart';
import 'package:school_companion_app/datastore.dart' as datastore;

class SubjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subjects")),
      body: CardDisplay(),
    );
  }
}

class CardDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = datastore.SubjectData();
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: data.getCount(),
      itemBuilder: (BuildContext context, int index) {
        var subjectData = data.getSubjectData(index);
        return SubjectItem(subjectData[0], subjectData[1]);
      },
    );
  }
}

class SubjectItem extends StatelessWidget {
  final String imageURL;
  final String subjectname;
  SubjectItem(this.subjectname, this.imageURL);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print("Clicked on $subjectname");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Topics(subjectname)));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                  constraints: new BoxConstraints.expand(
                    height: 250.0,
                  ),
                  padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage(imageURL), fit: BoxFit.cover),
                  ),
                  child: new Stack(
                    children: <Widget>[
                      new Positioned(
                        left: 0.0,
                        bottom: 20.0,
                        child: new Text(subjectname,
                            style: new TextStyle(
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 2.0),
                                Shadow(color: Colors.black, blurRadius: 4.0),
                                Shadow(color: Colors.black, blurRadius: 6.0),
                                Shadow(color: Colors.black, blurRadius: 8.0),
                                Shadow(color: Colors.black, blurRadius: 20.0),
                              ],
                              fontSize: 30.0,
                            )),
                      ),
                    ],
                  ))),
        ));
  }
}
