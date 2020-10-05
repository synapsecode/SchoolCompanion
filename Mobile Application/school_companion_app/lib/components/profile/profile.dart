import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_companion_app/datastore.dart' as datastore;
import 'package:school_companion_app/main.dart';

Map userProfile;

String reCapitalize(String name) {
  List words = name.split(" ");
  String returnString = "";
  if (words.length > 1) {
    for (var word in words) {
      word = word.toLowerCase();
      returnString +=
          "${word[0].toUpperCase()}${word.replaceFirst(word[0], "")} ";
    }
  } else {
    name = words[0].toLowerCase();
    returnString += "${name[0].toUpperCase()}${name.replaceFirst(name[0], "")}";
  }
  return returnString.trim();
}

class Profile extends StatefulWidget {
  final Map user;
  Profile(this.user);

  @override
  _ProfileState createState() {
    userProfile = user;
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 350.0,
          flexibleSpace: new FlexibleSpaceBar(background: SliverChild()),
        ),
        SliverList(delegate: SliverChildListDelegate([ProfileAppBody()]))
      ]),
    );
  }
}

class SliverChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/x.jpg'),
              //image: NetworkImage("https://picsum.photos/g/1000/1000/"),
              fit: BoxFit.cover)),
      child: new ProfileTopBar(),
    );
  }
}

class ProfileTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CompletionBarWithProfileIcon(),
        SizedBox(height: 10.0),
        Text(
          reCapitalize(userProfile['student_name']),
          style: TextStyle(fontSize: 35.0, shadows: [
            Shadow(color: Colors.black, blurRadius: 4.0),
            Shadow(color: Colors.black, blurRadius: 6.0),
            Shadow(color: Colors.black, blurRadius: 8.0),
            Shadow(color: Colors.black, blurRadius: 20.0),
          ]),
        ),
        // SizedBox(height: 10.0),
        // SizedBox(height: 10.0),
        EditButton(),
        // SizedBox(height: 10.0),
        // Center(child: new CoinIndicator())
      ],
    );
  }
}

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.0,
        child: RaisedButton(
          onPressed: () => print("Pressed Edit"),
          child: Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(width: 10.0),
              Text("Edit")
            ],
          ),
          color: Colors.blue.shade900,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));
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
      progressColor: Colors.blue.shade900,
    );
  }
}

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: CircleAvatar(
          radius: 54.0,
          backgroundImage: userProfile['thumbnailURI'] != null
              ? NetworkImage(userProfile['thumbnailURI'])
              : NetworkImage(
                  'https://www.startupdelta.org/wp-content/uploads/2018/04/No-profile-LinkedIn.jpg')),
      radius: 60.0,
      backgroundColor: Colors.white10,
    );
  }
}

class ProfileAppBody extends StatefulWidget {
  @override
  _ProfileAppBodyState createState() => _ProfileAppBodyState();
}

class _ProfileAppBodyState extends State<ProfileAppBody>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget rowItem(
      {String left,
      String right,
      Color leftColor = Colors.white54,
      Color rightColor = Colors.blue,
      alignment = MainAxisAlignment.spaceBetween,
      double fontSize = 19.0}) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            Flexible(
              child: Text("$left: ",
                  style: TextStyle(fontSize: fontSize, color: leftColor)),
            ),
            Flexible(
                child: Text(right,
                    style: TextStyle(fontSize: fontSize, color: rightColor)))
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15.0),
        color: Colors.black54,
        child: Column(
          children: <Widget>[
            Text(
              "Profile Data",
              style: TextStyle(fontSize: 50.0, color: Colors.white70),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  rowItem(left: "Grade", right: userProfile['grade']),
                  rowItem(left: "Section", right: userProfile['section']),
                  rowItem(
                      left: "Roll Number",
                      right: double.parse(userProfile['roll_no'])
                          .toInt()
                          .toString()),
                  rowItem(
                      left: "Gender",
                      right: userProfile['gender'] == "M" ? "Male" : "Female"),
                  rowItem(left: "E-Mail Address", right: userProfile['email']),
                  rowItem(left: "Phone Number", right: userProfile['phone']),
                  rowItem(left: "Date Of Birth", right: userProfile['dob']),
                  rowItem(
                      left: "Country",
                      right: reCapitalize(userProfile['country'])),
                  rowItem(
                      left: "State", right: reCapitalize(userProfile['state'])),
                  rowItem(
                      left: "City", right: reCapitalize(userProfile['city'])),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.blue.shade900,
                          child: Text("Security Questions"),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => new AlertDialog(
                                    title: new Text("Security Questions"),
                                    content: Container(
                                      height: 234.0,
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                                "Do not Share your Security answer with anyone!"),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            rowItem(
                                                left: "Security Question",
                                                right: userProfile[
                                                    'security_question'],
                                                alignment:
                                                    MainAxisAlignment.start),
                                            rowItem(
                                                left: "Security Answer",
                                                right: reCapitalize(userProfile[
                                                    'security_answer']),
                                                alignment:
                                                    MainAxisAlignment.start),
                                                    SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: RaisedButton(
                                                    color: Colors.black12,
                                                    child: Text(
                                                        "OK"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text("Log Out"),
                            onPressed: () {
                              datastore.destroyUserInfo();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RenderFlex()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
