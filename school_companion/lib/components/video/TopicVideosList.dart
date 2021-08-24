import 'package:flutter/material.dart';
import 'package:school_companion/components/video/VideoLandingPage.dart';
import 'package:school_companion/datastore.dart' as datastore;

class TopicVideoList extends StatelessWidget {
  final String topic;
  final Map<String, dynamic> userInfo = datastore.getUserInfo();
  TopicVideoList(this.topic);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: datastore.getVideosByTopic(topic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          var vid = snapshot.data['response'];
          print("\nRESULT: VIDEOS=> $vid");
          print("\nCompleted VideosByTopic Request");
          if (vid.length > 0) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("$topic"),
                ),
                body: VideoList(vid));
          } else {
            return Scaffold(
              body: Center(
                child: Container(
                  child: Text("No Videos Available for this Topic"),
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

class VideoList extends StatelessWidget {
  final List videos;
  VideoList(this.videos);
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: videos.length,
      itemBuilder: (BuildContext context, int index) {
        var subjectData = videos[index];
        return VideoItem(subjectData);
      },
    );
  }
}

class VideoItem extends StatelessWidget {
  final data;
  VideoItem(this.data);
  @override
  Widget build(BuildContext context) {
    final String thumbnail = data['thumbnailURI'];
    final String videoName = data['video_name'];
    final String topic = data['topic'];
    final String videoURI = data['videoURI'];
    final String subject = data['subject'];
    final String grade = data['grade'];
    final String desc = data['description'];

    return InkWell(
        onTap: () {
          print("Clicked on $videoName");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VideoLandingPage(
                        videoName: videoName,
                        thumbnail: thumbnail,
                        topic: topic,
                        videoURI: videoURI,
                        subject: subject,
                        grade: grade,
                        desc: desc,
                      )));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                  constraints: new BoxConstraints.expand(
                    height: 250.0,
                  ),
                  padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: NetworkImage(thumbnail), fit: BoxFit.cover),
                  ),
                  child: new Stack(
                    children: <Widget>[
                      new Positioned(
                        left: 1.0,
                        right: 1.0,
                        bottom: 20.0,
                        child: new Text(videoName,
                            style: new TextStyle(
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 2.0),
                                Shadow(color: Colors.black, blurRadius: 4.0),
                                Shadow(color: Colors.black, blurRadius: 6.0),
                                Shadow(color: Colors.black, blurRadius: 8.0),
                                Shadow(color: Colors.black, blurRadius: 20.0),
                              ],
                              fontSize: 30.0,
                            )),
                      ),
                    ],
                  ))),
        ));
  }
}
