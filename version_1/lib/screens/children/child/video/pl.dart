import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoHome extends StatefulWidget {
  final String url;
  const videoHome(this.url);

  @override
  State<videoHome> createState() => _videoHomeState();
}

class _videoHomeState extends State<videoHome> {
  late YoutubePlayerController controller1;
  late YoutubePlayer yp;
  late String id;
  @override
  void initState() {
    id = YoutubePlayer.convertUrlToId(widget.url)!;
    controller1 = YoutubePlayerController(
        initialVideoId: id,
        flags: YoutubePlayerFlags(
            loop: true,
            controlsVisibleAtStart: true,
            showLiveFullscreenButton: false,
            forceHD: true));
    yp = YoutubePlayer(controller: controller1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    id = YoutubePlayer.convertUrlToId(widget.url)!;
    controller1.load(id);
    return Container(child: yp);
  }
}
