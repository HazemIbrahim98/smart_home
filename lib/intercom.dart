import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'constats.dart';

class Intercom extends StatefulWidget {
  @override
  _IntercomState createState() => _IntercomState();
}

class _IntercomState extends State<Intercom> {
  VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      rtspIP,
      hwAcc: HwAcc.FULL,
      onInit: () {
        _videoPlayerController.play();
      },
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _videoPlayerController.startRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
