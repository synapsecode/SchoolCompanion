import 'package:flutter/material.dart';
import 'package:school_companion/datastore.dart' as datastore;

Map<String, dynamic> userData = datastore.getUserInfo();

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
          color: Colors.black26,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 270.0,
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.blue.shade900,
                    backgroundImage: userData['thumbnailURI'] != null
                        ? NetworkImage(userData['thumbnailURI'])
                        : NetworkImage(
                            'https://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn.jpg'),
                  ),
                  accountName: Text(userData['student_name']),
                  accountEmail: Text(userData['email']),
                  decoration: new BoxDecoration(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              SizedBox(
                height: 200.0,
                width: 200.0,
                child: Image.asset('assets/logo.png', fit: BoxFit.contain),
              ),
              Text(
                "St Paul's English School",
                style: TextStyle(fontSize: 25.0, color: Colors.white70),
              ),
              Text(
                "Created By Manas Hejmadi ©",
                style: TextStyle(fontSize: 15.0, color: Colors.white70),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                "Version 0.1.0-alpha",
                style: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ],
          )),
    );
  }
}

/*
new ListView(
          children: <Widget>[
            new SizedBox(
              height: 270.0,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue.shade900,
                  backgroundImage: userData['thumbnailURI'] != null
                      ? NetworkImage(userData['thumbnailURI'])
                      : NetworkImage(
                          'https://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn.jpg'),
                ),
                accountName: Text(userData['student_name']),
                accountEmail: Text(userData['email']),
                decoration: new BoxDecoration(
                  
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            new ListTile(
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onTap: () {},
            ),
            new ListTile(
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onTap: () {},
            ),
          ],
        ),*/
