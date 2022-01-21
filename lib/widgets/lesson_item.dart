import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/screens/video_player_screen.dart';
import 'package:e_learning_sc/widgets/lesson_item_horizontal.dart';
import 'package:e_learning_sc/widgets/lesson_item_vertical.dart';
import 'package:flutter/material.dart';

class LessonItem extends StatelessWidget {
  bool vertical;
  Lesson lesson;
  Course course;
  bool mini;
  bool currentLesson;

  LessonItem(
      {required this.lesson,
      required this.course,
      this.vertical = true,
      this.mini = false,
      this.currentLesson = false});

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return InkWell(
        child: LessonItemVertical(
          lesson: lesson,
          mini: mini,
          currentLesson: currentLesson,
        ),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      course: course,
                      lesson: lesson,
                    )),
          );
        },
      );
    }

    return InkWell(
      child: LessonItemHorizontal(
        lesson: lesson,
        mini: mini,
        currentLesson: currentLesson,
      ),
      onTap: () {
        if (mini)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      course: course,
                      lesson: lesson,
                    )),
          );
        else
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      course: course,
                      lesson: lesson,
                    )),
          );
      },
    );
  }
}
