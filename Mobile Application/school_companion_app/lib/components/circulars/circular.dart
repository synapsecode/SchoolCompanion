import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// class CircularViewer extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: datastore.getCircularByid(id),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.data != null) {
//           var circular = snapshot.data;
//           print("\nRESULT: circular => $circular");
//           print("\nCompleted GetcircularByID Request");
//           if (circular.length > 0) {
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text("Circular"),
//                 ),
//                 body: CircularItem(circular));
//           } else {
//             print("No circulars Available");
//             return Scaffold(
//               body: Center(
//                 child: Container(
//                   child: Text("No circulars Available"),
//                 ),
//               ),
//             );
//           }
//         } else {
//           return Scaffold(
//             body: Center(
//               child: Container(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class CircularViewer extends StatelessWidget {
  final String title;
  final String documentURI;
  final String message;
  final String sentDate;

  CircularViewer(this.title, this.message, this.documentURI, this.sentDate);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Circular"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 60.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Date Issued: ",
                      style: TextStyle(fontSize: 23.0),
                    ),
                    Text(
                      sentDate,
                      style: TextStyle(fontSize: 23.0, color: Colors.white30),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      color: Colors.black12,
                      padding: EdgeInsets.all(20.0),
                      child: Column(children: <Widget>[
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                child: Text("Open Circular"),
                                color: Colors.blue.shade600,
                                onPressed: () => launch(documentURI),
                              ),
                            )
                          ],
                        )
                      ])),
                ),
              ],
            ),
          ),
        ));
  }
}
