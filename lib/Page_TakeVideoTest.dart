import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class Page_TakeVideoTest extends StatefulWidget {
  String videoLink;
  Page_TakeVideoTest(this.videoLink);
  _Page_TakeVideoTestState createState() => _Page_TakeVideoTestState(videoLink);
}

class _Page_TakeVideoTestState extends State<Page_TakeVideoTest> {
  String videoLink;
  _Page_TakeVideoTestState(this.videoLink);
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoLink)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F7FF),
      body: Container(
          child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.only(top: 50, left: 20),
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset("assets/backcolored.svg")),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                "Test",
                style: TextStyle(
                    color: Color(0xff152643),
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
            )
          ]),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: VideoPlayer(_controller),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
