import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/back_button.dart';
import 'package:e_learning_sc/widgets/content_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:loading_indicator/loading_indicator.dart';

const List<Color> _kDefaultRainbowColors = const [
  App.gold,
  App.primaryColor,
  Colors.lightGreen,
  Colors.redAccent,
  Colors.indigoAccent
];

class VideoPlayerScreen extends StatefulWidget {
  Course course;
  Lesson lesson;
  //final DocumentSnapshot document;

  VideoPlayerScreen({required this.course, required this.lesson});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreen();
  }
}

class _VideoPlayerScreen extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late File file;
  bool fetchVideoFromOnline = true;

  @override
  void initState() {
    initPlatformState();
    super.initState();
    //print("URL " + widget.lesson.video_url);

    initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    _controller = fetchVideoFromOnline
        ? VideoPlayerController.network(widget.lesson.video_url)
        : VideoPlayerController.file(file);
    _controller.addListener(() {
      setState(() {});
    });
    //_controller.setLooping(true);

    await Future.wait([_controller.initialize()]);

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      videoPlayerController: _controller,
      autoInitialize: true,
      autoPlay: true,
      showControls: true,
    );
    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });

    _controller.play();
  }

  void initPlatformState() async {
    print('Cache init ' + widget.lesson.video_url);
    FileInfo? fileInfo = await DefaultCacheManager()
        .getFileFromCache(widget.lesson.video_url); //url of video

    File? _file = fileInfo?.file;

    if (fileInfo == null) {
      print('cache ln: caching now ');

      setState(() {
        fetchVideoFromOnline = true;
      });

      file = await DefaultCacheManager().getSingleFile(
          widget.lesson.video_url); //here we provide the url of video to cache.
    } else {
      print('cache ln: ${fileInfo.validTill}');
      setState(() {
        fetchVideoFromOnline = false;
        file = fileInfo.file;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerScreen(context);
  }

  Widget videoPlayerScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: videoPlayerScreenUI(context)),
    );
  }

  Widget videoPlayerScreenUI(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    //App.primaryColor,
                    borderRadius: BorderRadius.only(
                        //bottomLeft: Radius.circular(30),
                        //bottomRight: Radius.circular(30)
                        ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 0.1,
                        spreadRadius: 0.1,
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  //: EdgeInsets.all(10),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            child: Container(
                              child: Text(
                                "👈",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF333333),
                                  //Colors.white,
                                  fontWeight: FontWeight.bold,
                                  //fontFamily:
                                ),
                                textAlign: TextAlign.center,
                              ),
                              /*Icon(
                            Icons.arrow_back_rounded, // arrow_back_ios_sharp
                            color: App.myBlack, size: 30,
                          ),*/
                              margin: EdgeInsets.only(right: 0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        Text(
                          widget.course.title, //"Aprende sobre matematicas",
                          style: TextStyle(
                            fontSize: 21,
                            color: App.myBlack,
                            //Colors.white,
                            fontWeight: FontWeight.w900,
                            //fontFamily:
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/logo_black.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  )),
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          //VideoPlayer(_controller),
                          //_ControlsOverlay(controller: _controller),
                          Chewie(
                            controller: _chewieController,
                          ),
                          /*VideoProgressIndicator(_controller, allowScrubbing: true,
                    colors: VideoProgressColors(
                        backgroundColor: Colors.white,
                      playedColor: App.primaryColor
                    ),
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                    ),*/
                        ],
                      ))
                  : Container(
                      width: screenWidth,
                      height: 220,
                      decoration: BoxDecoration(
                        /*image: DecorationImage(
                      image: NetworkImage(widget.lesson.image_url),
                      fit: BoxFit.cover
                  ),*/
                        color: Colors.white10,
                      ),
                      child: Center(
                          child: Container(
                        height: 100,
                        width: 100,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballGridPulse,
                          colors: _kDefaultRainbowColors,
                          strokeWidth: 1.0,
                          //pathBackgroundColor: showPathBackground ? Colors.black45 : null,
                        ),
                      )),
                    ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      widget.lesson.title,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.lesson.description,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        maxLines: 3,
                      ),
                      height: 55,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              ContentList(
                contentList: widget.course.contentList,
                mini: true,
                course: widget.course,
              )
            ],
          ),
        ),
        /*Positioned(
          left: 20,
          top: 20,
          child: MyBackButton(size: 30,),
        )*/
      ],
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
