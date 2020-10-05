import 'package:flutter/material.dart';
import 'package:school_companion_app/components/video/videoplayer.dart';

class VideoLandingPage extends StatelessWidget {
  final String thumbnail;
  final String videoName;
  final String topic;
  final String videoURI;
  final String subject;
  final String grade;
  final String desc;
  VideoLandingPage({this.videoName, this.videoURI, this.thumbnail, this.subject, this.topic, this.desc, this.grade});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                HeaderContainer(
                  videoName: videoName,
                  thumbnail: thumbnail,
                  topic: topic,
                  videoURI: videoURI,
                ),
                AppBar(backgroundColor: Colors.transparent),
              ],
            ),
            VideoLandingPageScreenBottomPart(
              subject: subject,
              topic: topic,
              desc: desc,
              grade: grade,
            )
          ],
        ),
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  final String thumbnail;
  final String videoName;
  final String topic;
  final String videoURI;
  HeaderContainer({this.videoName, this.thumbnail, this.topic, this.videoURI});
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 420.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Mclipper(),
            child: Container(
              height: 370.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 10.0),
                    blurRadius: 10.0)
              ]),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(thumbnail),
                            fit: BoxFit.cover),
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x00000000),
                              const Color(0xD9333333)
                            ],
                            stops: [
                              0.0,
                              0.9
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 120.0, left: 95.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            topic,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold",
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 2.0),
                                  Shadow(color: Colors.black, blurRadius: 4.0),
                                  Shadow(color: Colors.black, blurRadius: 6.0),
                                  Shadow(color: Colors.black, blurRadius: 8.0),
                                  Shadow(color: Colors.black, blurRadius: 20.0),
                                ]),
                          ),
                          Text(
                            videoName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.0,
                                fontFamily: "SF-Pro-Display-Bold",
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 2.0),
                                  Shadow(color: Colors.black, blurRadius: 4.0),
                                  Shadow(color: Colors.black, blurRadius: 20.0),
                                ]),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 370.0,
            right: -20.0,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: Color(0xFFE52020),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: RaisedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AppVideoPlayer(videoURI))),
                      color: Color(0xFFE52020),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 80.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Watch Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "SF-Pro-Display-Bold"),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(Icons.arrow_back,
                                size: 25.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VideoLandingPageScreenBottomPart extends StatelessWidget {
  final String topic;
  final String subject;
  final String grade;
  final String desc;
  VideoLandingPageScreenBottomPart({this.subject, this.desc, this.grade, this.topic});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45.0,
                fontFamily: "SF-Pro-Display-Bold",
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(desc),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Text("Subject:"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    getSubject(subject),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: <Widget>[
                Text("Grade:"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    getGrade(grade),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            Row(
              children: <Widget>[
                Text("Topic:"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    topic,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Mclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 100.0);

    var controlpoint = Offset(35.0, size.height);
    var endpoint = Offset(size.width / 2, size.height);

    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

String getSubject(String subject) {
  switch (subject) {
    case "PHY":
      subject = "Physics";
      break;
    case "CHEM":
      subject = "Chemistry";
      break;
    case "BIO":
      subject = "Biology";
      break;
    case "MAT":
      subject = "Mathematics";
      break;
    case "HIS":
      subject = "History & Civics";
      break;
    case "GEO":
      subject = "Geography";
      break;
    case "ENG1":
      subject = "English Grammar";
      break;
    case "ENG2":
      subject = "English Literature";
      break;
    case "COMP":
      subject = "Computer Applications";
      break;
    case "PE":
      subject = "Physical Education";
      break;
    case "LNG":
      subject = "Second Language";
      break;
  }
  return subject;
}

String getGrade(String grade) {
  return grade != "ISC"
      ? grade == "A" ? "Everyone" : grade.replaceAll("G", "").toString()
      : "ISC";
}
