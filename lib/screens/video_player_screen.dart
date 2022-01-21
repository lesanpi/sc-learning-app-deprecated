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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  // late VideoPlayerController _controller;
  // late ChewieController _chewieController;
  late File file;
  bool fetchVideoFromOnline = true;

  late YoutubePlayerController _controller;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  late int _rotation;

  @override
  void initState() {
    _rotation = 0;
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.lesson.video_id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
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
    double screenHeight = MediaQuery.of(context).size.height;

    bool fullScreen = false;
    return Column(
      children: [
        _rotation == 1
            ? SizedBox.shrink()
            : Container(
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
                            child: const Text(
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
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        widget.course.title, //"Aprende sobre matematicas",
                        style: const TextStyle(
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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/logo_black.png'),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                )),
        Expanded(
          child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              bottomActions: <Widget>[
                IconButton(
                  icon: Icon(
                    _rotation == 0 ? Icons.fullscreen : Icons.fullscreen_exit,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    _controller.pause();
                    if (_rotation == 0) {
                      setState(() {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive);
                        SystemChrome.setSystemUIOverlayStyle(
                            const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          systemNavigationBarColor: Colors.transparent,
                          systemNavigationBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.light,
                          statusBarIconBrightness: Brightness.dark,
                        ));
                        _rotation = 1;
                      });
                    } else {
                      setState(() {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.edgeToEdge);
                        _rotation = 0;
                      });
                    }
                  },
                ),
                RemainingDuration(),
                ProgressBar(isExpanded: true),
                CurrentPosition(),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                // _controller.load(
                //     _ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                // _showSnackBar('Next Video Started!');
              },
            ),
            builder: (context, player) {
              return Expanded(
                child: Container(
                  width: screenWidth,
                  child: RotatedBox(
                    quarterTurns: _rotation,
                    child: player,
                  ),
                ),
              );
              // ;
            },
          ),
        ),
        _rotation == 1
            ? SizedBox.shrink()
            : Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      widget.lesson.title,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      child: Text(
                        widget.lesson.description,
                        style: const TextStyle(
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
        _rotation == 1
            ? SizedBox.shrink()
            : ContentList(
                contentList: widget.course.contentList,
                mini: true,
                course: widget.course,
                currentContentId: widget.lesson.id,
              )
      ],
    );
  }
}
