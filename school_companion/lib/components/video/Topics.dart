import 'package:flutter/material.dart';
import 'package:school_companion/components/video/TopicVideosList.dart';
import 'package:school_companion/datastore.dart' as datastore;

class Topics extends StatelessWidget {
  final String subject;
  final Map<String, dynamic> userInfo = datastore.getUserInfo();
  Topics(this.subject);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: datastore.getTopics(userInfo["grade"], subject),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          var topics = snapshot.data['response'];
          print("\nRESULT: TOPICS => $topics");
          print("\nCompleted GetTopic Request");
          if (topics.length > 0) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("$subject Topics"),
                ),
                body: TopicsList(topics));
          } else {
            print("No Topics Available");
            return Scaffold(
              body: Center(
                child: Container(
                  child: Text("No Topics Available"),
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

class TopicsList extends StatelessWidget {
  final List topics;
  TopicsList(this.topics);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          title: Text(topics[index]),
          onTap: () {
            print("Clicked On ${topics[index]}");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TopicVideoList(topics[index])));
          },
        );
      },
    );
  }
}
