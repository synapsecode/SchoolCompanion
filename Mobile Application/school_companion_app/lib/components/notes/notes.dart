import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesView extends StatelessWidget {
  final List a;
  NotesView(this.a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Notes"),
        ),
        body: Notes(a));
  }
}

class Notes extends StatelessWidget {
  final List x;
  Notes(this.x);

  @override
  Widget build(BuildContext context) {
    int papers = x.length;
    return GridView.count(
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        crossAxisCount: 2,
        padding: EdgeInsets.all(10.0),
        children: List.generate(papers, (index) {
          return NotesItem(x[index]);
        }));
  }
}

class NotesItem extends StatelessWidget {
  final Map a;
  NotesItem(this.a);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        launch(a['notesURI']);
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
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: Text(a['notes_name'],
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 20.0
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
