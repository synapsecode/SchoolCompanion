import 'package:flutter/material.dart';
import 'package:school_companion_app/datastore.dart' as datastore;
import './circular.dart';

class CircularsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Entered NP");
    return FutureBuilder(
      future: datastore.getCircularsByGrade(datastore.getUserInfo()["grade"]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          var circulars = snapshot.data;
          print("\nRESULT: circulars => $circulars");
          print("\nCompleted GetcircularsByGrade Request");
          if (circulars.length > 0) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("School circulars"),
                ),
                body: ReminderList(circulars));
          } else {
            print("No circulars Available");
            return Scaffold(
              body: Center(
                child: Container(
                  child: Text("No circulars Available"),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class ReminderList extends StatelessWidget {
  final List<Map<String, String>> circulars;
  ReminderList(this.circulars);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: circulars.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, String> circular = circulars[index];
        return ListTile(
          onTap: () {
            String documentURI = circular['documentURI'];
            String title = circular['title'];
            String message = circular['message'];
            String sentDate = circular['sent_date'];
            print("Clicked on Circular");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CircularViewer(title, message, documentURI, sentDate)));
          },
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
          ),
          title: Text(circular['title']),
          trailing: Text(
            circular['sent_date'],
            style: TextStyle(color: Colors.white54),
          ),
        );
      },
    );
  }
}
