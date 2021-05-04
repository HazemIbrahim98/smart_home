import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class Intercom extends StatefulWidget {
  @override
  _IntercomState createState() => _IntercomState();
}

class _IntercomState extends State<Intercom> {
  final String urlToStreamVideo = 'rtsp://Kimo123:a7laproject@192.168.1.123:554/stream2';
  VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController= VlcPlayerController.network(
      urlToStreamVideo,
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
    // TODO: implement dispose
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
          aspectRatio: 16/9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
