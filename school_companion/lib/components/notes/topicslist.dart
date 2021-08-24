import 'package:flutter/material.dart';
import 'package:school_companion/components/notes/notes.dart';

class TopicsList extends StatelessWidget {
  final List topics;
  TopicsList(this.topics);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            title: Text(topics[index]['topic_name']),
            onTap: () {
              print("Clicked On ${topics[index]}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          NotesView(topics[index]['topic_notes'])));
            },
          );
        },
      ),
    );
  }
}
