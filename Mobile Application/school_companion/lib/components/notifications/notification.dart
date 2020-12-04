import 'package:flutter/material.dart';

// class NotificationViewer extends StatelessWidget {
//   final String id;
//   NotificationViewer(this.id);
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: datastore.getNotificationByid(id),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.data != null) {
//           var notification = snapshot.data;
//           print("\nRESULT: NOTIFICATIONS => $notification");
//           print("\nCompleted GetNotificationsByID Request");
//           if (notification.length > 0) {
//             return Scaffold(
//                 appBar: AppBar(
//                   title: Text("Notification"),
//                 ),
//                 body: NotificationItem(notification));
//           } else {
//             print("No Notifications Available");
//             return Scaffold(
//               body: Center(
//                 child: Container(
//                   child: Text("No Notifications Available"),
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

class NotificationViewer extends StatelessWidget {
  final String title;
  final String message;
  final String sentDate;

  NotificationViewer(this.title, this.message, this.sentDate);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notifications")),
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
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
