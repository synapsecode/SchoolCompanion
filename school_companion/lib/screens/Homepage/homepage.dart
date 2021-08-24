import 'package:flutter/material.dart';
import 'package:school_companion/components/attendance/getdata.dart';
import 'package:school_companion/components/notes/getdata.dart';
import 'package:school_companion/components/notifications/notifications.dart';
import 'package:school_companion/components/circulars/circulars.dart';
import 'package:school_companion/components/profile/profile.dart';
import 'package:school_companion/components/results/getdata.dart';
import 'package:school_companion/components/samplepapers/getdata.dart';
import './sidebar.dart';
import 'package:school_companion/components/video/subjects.dart';
import 'package:school_companion/datastore.dart' as datastore;
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

Map<String, dynamic> userData;

class Home extends StatefulWidget {
  final Map<String, dynamic> data;
  Home(this.data);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // @override
  // void initState() {
  //   super.initState();
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       final notification = message['data'];
  //       print("Notification: $notification");
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //       const IosNotificationSettings(sound: true, badge: true, alert: true));
  // }

  @override
  void initState() {
    super.initState();
    // OneSignal.shared.init("0226e2d0-cc32-4ec7-9315-f34981cedcd7");
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    userData = widget.data;
    return Scaffold(
        appBar: AppBar(
          title: Text("School Companion"),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  print("Clicked On Notifications");
                },
                child: Icon(Icons.notifications)),
            SizedBox(width: 10.0),
            InkWell(
                onTap: () {
                  print("Clicked On Profile");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Profile(datastore.getUserInfo())));
                },
                child: Icon(Icons.person)),
            SizedBox(width: 10.0),
            InkWell(
                onTap: () {
                  print("Clicked On Actions");
                },
                child: Icon(Icons.more_vert)),
          ],
        ),
        drawer: Sidebar(),
        body: HomePageBody());
  }
}

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ProfileCard(),
        ActionCard(Icons.videocam, "Videos", () {
          print("Clicked On Video");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SubjectsPage()));
        }),
        ActionCard(Icons.equalizer, "Results", () {
          print("Clicked On Results");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ResultDataForm()));
        }),
        ActionCard(Icons.people, "Attendance", () {
          print("Clicked On Attendance");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AttendanceDataForm()));
        }),
        ActionCard(Icons.attachment, "Sample Papers", () {
          print("Clicked On Sample Papers");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SamplePaperDataForm()));
        }),
        ActionCard(Icons.import_contacts, "Notes", () {
          print("Clicked On Notes");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NotesDataForm()));
        }),
        ActionCard(Icons.info, "Circulars", () {
          print("Clicked On Circulars");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CircularsPage()));
        }),
        ActionCard(Icons.notifications_active, "Notifications", () {
          print("Clicked On Notifications");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NotificationsPage()));
        }),
        Footer()
      ],
    ));
  }
}

class ProfileCard extends StatelessWidget {
  String convertName(String name) {
    name = name.split(" ")[0].toLowerCase();
    return "${name[0].toUpperCase()}${name.replaceFirst(name[0], "")}";
  }

  @override
  Widget build(BuildContext context) {
    String studentName = userData['student_name'];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade900,
              padding: new EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  CompletionBarWithProfileIcon(),
                  //"Welcome ${studentName.split(' ')[0]}"
                  Text(
                    "Welcome ${convertName(studentName)}",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      print("Clicked on View Profile");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Profile(datastore.getUserInfo())));
                    },
                    child: Text("View Profile"),
                  )
                ],
              ))),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue.shade900,
              padding: new EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/logo.png'),
                                fit: BoxFit.contain)),
                        height: 80.0,
                        width: 80.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text("St Paul's English School",
                          style: TextStyle(fontSize: 18.0))
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text("All Rights Reserved, Manas Hejmadi ©"),
                  )
                ],
              ))),
    );
  }
}

class CompletionBarWithProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 10.0,
      percent: 0.8,
      center: ProfileIcon(),
      backgroundColor: Colors.grey,
      progressColor: Colors.blue.shade800,
    );
  }
}

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: CircleAvatar(
          radius: 54.0,
          backgroundImage: userData['thumbnailURI'] != null
              ? NetworkImage(userData['thumbnailURI'])
              : NetworkImage(
                  'https://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn.jpg')),
      radius: 60.0,
      backgroundColor: Colors.white10,
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData leadingIcon;
  final String actionTitle;
  final Function eventHandler;
  ActionCard(this.leadingIcon, this.actionTitle, this.eventHandler);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              padding:
                  new EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        leadingIcon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        actionTitle,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  RaisedButton(
                    color: Colors.blue.shade900,
                    onPressed: eventHandler,
                    child: Text("View"),
                  )
                ],
              ))),
    );
  }
}
