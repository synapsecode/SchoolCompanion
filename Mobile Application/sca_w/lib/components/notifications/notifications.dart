import 'package:flutter/material.dart';
import 'package:school_companion_app/datastore.dart' as datastore;
import './notification.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Entered NP");
    return FutureBuilder(
      future:
          datastore.getNotificationsByGrade(datastore.getUserInfo()["grade"]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          var notifications = snapshot.data;
          print("\nRESULT: NOTIFICATIONS => $notifications");
          print("\nCompleted GetNotificationsByGrade Request");
          if (notifications.length > 0) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("School Notifications"),
                ),
                body: NotificationList(notifications));
          } else {
            print("No Notifications Available");
            return Scaffold(
              body: Center(
                child: Container(
                  child: Text("No Notifications Available"),
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

class NotificationList extends StatelessWidget {
  final List<Map<String, String>> notifications;
  NotificationList(this.notifications);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        Map<String, String> notification = notifications[index];
        return ListTile(
          onTap: () {
            String title = notification['title'];
            String message = notification['message'];
            String sentDate = notification['sent_date'];
            print("Clicked on Notification");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        NotificationViewer(title, message, sentDate)));
          },
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
          ),
          title: Text(notification['title']),
          trailing: Text(
            notification['sent_date'],
            style: TextStyle(color: Colors.white54),
          ),
        );
      },
    );
  }
}
