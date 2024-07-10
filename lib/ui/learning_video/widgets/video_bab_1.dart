import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoBab1 extends StatefulWidget {
  final String videoURL;

  const VideoBab1({super.key, required this.videoURL});

  @override
  State<VideoBab1> createState() => _VideoBab1State();
}

class _VideoBab1State extends State<VideoBab1> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoURL);

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint('ready'),
              bottomActions: [
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: Colors.white,
                    handleColor: Colors.white,
                  ),
                ),
                const PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
