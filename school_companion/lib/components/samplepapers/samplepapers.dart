import 'package:flutter/material.dart';
import 'package:school_companion/datastore.dart' as datastore;
import 'package:url_launcher/url_launcher.dart';

class SamplePaperView extends StatelessWidget {
  final Map<String, dynamic> a;
  SamplePaperView(this.a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "${datastore.getSubject(a['response'][0]['subject'])} Papers"),
        ),
        body: Attendance(a));
  }
}

class Attendance extends StatelessWidget {
  final Map<String, dynamic> a;
  Attendance(this.a);

  @override
  Widget build(BuildContext context) {
    List x = a['response'];
    int papers = x.length;
    return GridView.count(
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        children: List.generate(papers, (index) {
          return PaperItem(x[index]);
        }));
  }
}

class PaperItem extends StatelessWidget {
  final Map a;
  PaperItem(this.a);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launch(a['paper_url']);
      },
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/qpbck.jpg'), fit: BoxFit.cover)),
            height: 70.0,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child: Text(
                    a['year'],
                    style: TextStyle(fontSize: 30.0, color: Colors.white24),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 13.0,
                  right: 1.0,
                  child: Text(
                    a['paper_name'],
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
