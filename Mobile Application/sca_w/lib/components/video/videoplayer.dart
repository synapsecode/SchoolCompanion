import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/src/chewie_player.dart';

class AppVideoPlayer extends StatelessWidget {
  final String videoURI;
  AppVideoPlayer(this.videoURI);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Video Player")),
        body: Center(
            child: Player(
          videoPlayerController: VideoPlayerController.network(videoURI),
        )));
  }
}

class Player extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  Player({@required this.videoPlayerController, this.looping});

  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  ChewieController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: widget.looping,
        errorBuilder: (BuildContext context, String errorMessage) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _controller.dispose();
  }
}
