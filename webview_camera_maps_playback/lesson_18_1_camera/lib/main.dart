import 'dart:async';
import 'dart:io';
//import 'dart:html';
//import 'dart:ffi';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final List<Map<String, dynamic>> tabBarNav = [
    {
      'icon': const Icon(Icons.camera),
      'label': 'Camera',
    },
    {
      'icon': const Icon(Icons.image),
      'label': 'Gallary',
    },
  ];

  late TabController _tabController;
  int _currentTabIndex = 0;
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  XFile? _lastImage;
  final List<XFile> _lastImages = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: tabBarNav.length,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });

    unawaited(initCamera());
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //super.didChangeAppLifecycleState(state);
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    await _controller!.initialize();
    setState(() {});
  }

  Future<void> takePicture() async {
    _lastImage = await _controller?.takePicture();
    _lastImages.add(_lastImage!);
    setState(() {});
  }

  void _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = cameraController;
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: _controller?.value.isInitialized == true
                ? CameraPreview(_controller!)
                : const CircularProgressIndicator(),
          ),
          _lastImage != null
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                  return constraints.constrainWidth() >= 600
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                constraints.constrainWidth() >= 900 ? 3 : 2,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: _lastImages.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  File(_lastImages[
                                          _lastImages.length - 1 - index]
                                      .path),
                                  fit: BoxFit.contain,
                                ),
                              ))
                      : ListView.builder(
                          itemCount: _lastImages.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(_lastImages[_lastImages.length - 1 - index]
                                  .path),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                })
              : const Center(
                  child: Text('No images yet'),
                ),
        ],
      ),
      floatingActionButton: _currentTabIndex > 0
          ? null
          : FloatingActionButton(
              onPressed: takePicture,
              tooltip: 'Make a photo',
              child: const Icon(Icons.camera),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
            _tabController.index = index;
          });
        },
        currentIndex: _currentTabIndex,
        items: tabBarNav
            .map(
              (item) => BottomNavigationBarItem(
                icon: item['icon'],
                label: item['label'],
              ),
            )
            .toList(),
      ),
    );
  }
}
