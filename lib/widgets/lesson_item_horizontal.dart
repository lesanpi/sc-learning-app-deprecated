import 'package:e_learning_sc/model/Lesson.dart';
import 'package:flutter/material.dart';

class LessonItemHorizontal extends StatelessWidget {
  Lesson lesson;
  bool mini;
  bool currentLesson;
  LessonItemHorizontal(
      {required this.lesson, this.mini = false, this.currentLesson = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double itemHeight = 210;

    if (this.mini) return Container();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 1,
              spreadRadius: 0.1,
            )
          ]),
      width: screenWidth * 2 / 3,
      child: Column(
        children: [
          Container(
            height: itemHeight * 0.6,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage(lesson.image_url), fit: BoxFit.cover)),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  lesson.description,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            padding: EdgeInsets.all(10),
            height: itemHeight * 0.4,
          )
        ],
      ),
      margin: EdgeInsets.only(right: 20),
    );
  }
}
