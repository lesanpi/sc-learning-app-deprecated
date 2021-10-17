import 'package:e_learning_sc/model/Content.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/content_list.dart';
import 'package:e_learning_sc/widgets/course_list.dart';
import 'package:e_learning_sc/widgets/guide_list.dart';
import 'package:e_learning_sc/widgets/lesson_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget{

  Course course;
  Lesson lesson;

  VideoPlayerScreen({required this.course, required this.lesson});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreen();
  }

}

class _VideoPlayerScreen extends State<VideoPlayerScreen>{
  late VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      //"https://streamable.com/5kme5g",
      //"https://drive.google.com/file/d/1pWQTqFYogustPnXigo3lOVOCHm5vqAms/view?usp=sharing"
      "https://github.com/lesanpi/sc-elearning/blob/master/static/videos/video.mp4"
    );

    _controller.addListener(() {
      setState(() {});
    });
    //_controller.setLooping(true);
    _controller.initialize();
    _controller.play();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return videoPlayerScreen(context);
  }

  Widget videoPlayerScreen(BuildContext context){
    return Scaffold(
      body: videoPlayerScreenUI(context),
    );
  }

  Widget videoPlayerScreenUI(BuildContext context){

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              _controller.value.isInitialized
              ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    _ControlsOverlay(controller: _controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true,
                    colors: VideoProgressColors(
                        backgroundColor: Colors.white,
                      playedColor: Color(0xFF2ed1c4)
                    ),
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                    ),
                  ],
                )
              ) : Container(
                color: Colors.black,
                width: screenWidth,
                height: 300
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: 20
                ),
                margin: EdgeInsets.only(
                    top: 10
                ),
                child: Column(
                  children: [
                    Text(
                      widget.lesson.title,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.lesson.description,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),
                        maxLines: 3,
                      ),
                      height: 55,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              ContentList(contentList: widget.course.content_list, mini: true, course: widget.course,)
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 50,
          child: InkWell(
            child: Container(
              width: 50,
              height: 50,
              child: Icon(Icons.arrow_back_ios), decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                )
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
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