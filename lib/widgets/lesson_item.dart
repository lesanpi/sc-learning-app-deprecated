import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/screens/video_player_screen.dart';
import 'package:e_learning_sc/widgets/lesson_item_horizontal.dart';
import 'package:e_learning_sc/widgets/lesson_item_vertical.dart';
import 'package:flutter/material.dart';

class LessonItem extends StatelessWidget{

  bool vertical;
  Lesson lesson;
  Course course;
  bool mini;

  LessonItem({required this.lesson, required this.course, this.vertical = true, this.mini=false});

  @override
  Widget build(BuildContext context) {
    if (this.vertical)
      return InkWell(
        child: LessonItemVertical(lesson: lesson, mini: this.mini),
        onTap: (){

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VideoPlayerScreen(course: course, lesson: lesson,)),
          );
        },
      );

    return InkWell(
      child: LessonItemHorizontal(lesson: lesson, mini: this.mini),
      onTap: (){
        if (mini)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => VideoPlayerScreen(course: course, lesson: lesson,)),
          );
        else
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VideoPlayerScreen(course: course, lesson: lesson,)),
          );
      },
    );

  }

}