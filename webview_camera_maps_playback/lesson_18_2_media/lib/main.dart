import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoPlayerController;
  Duration _position = const Duration();

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position.inSeconds !=
          _position.inSeconds) {
        setState(() {
          _position = _videoPlayerController.value.position;
        });
      }
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize().then((value) => setState(() {
          _position = _videoPlayerController.value.position;
        }));
    _videoPlayerController.play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: 200,
        child: Stack(
          children: [
            VideoPlayer(_videoPlayerController),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(_position.toString().split('.').first.padLeft(8, "0")),
                    Expanded(
                      child: Slider(
                        min: 0.0,
                        max: _videoPlayerController.value.duration.inSeconds
                            .roundToDouble(),
                        value: _position.inSeconds.roundToDouble(),
                        onChanged: (double newPosition) {
                          _videoPlayerController
                              .seekTo(Duration(seconds: newPosition.floor()));
                        },
                      ),
                    ),
                    Text(_videoPlayerController.value.duration
                        .toString()
                        .split('.')
                        .first
                        .padLeft(8, "0")),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        },
                        icon: Icon(_videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: () {
                          _videoPlayerController
                              .seekTo(_position - const Duration(seconds: 5));
                        },
                        icon: const Icon(Icons.replay_5),
                      ),
                      IconButton(
                        onPressed: () {
                          _videoPlayerController
                              .seekTo(_position + const Duration(seconds: 5));
                        },
                        icon: const Icon(Icons.forward_5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
