import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.videoController}) : super(key: key);

  final VideoPlayerController videoController;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfffd3015),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 250),
      child: widget.videoController.value.isInitialized
          ? VideoPlayer(
        widget.videoController,
      )
          : Container(),
    );
  }
}
