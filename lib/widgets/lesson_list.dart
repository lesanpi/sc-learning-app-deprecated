import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/lesson_item.dart';
import 'package:e_learning_sc/widgets/lesson_item_horizontal.dart';
import 'package:e_learning_sc/widgets/lesson_item_vertical.dart';
import 'package:flutter/material.dart';

class LessonList extends StatelessWidget {
  double screenWidth = 0;
  double itemHeight = 210;
  List<Lesson> lessonList;
  bool vertical;

  LessonList({this.lessonList = const [], this.vertical = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    this.screenWidth = screenWidth;
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: vertical ? 10 : 0,
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: correctListItemWidget(lessonList, isDarkTheme),
      ),
    );
  }

  List<Widget> correctListItemWidget(
      List<Lesson> lessonList, bool isDarkTheme) {
    List<Widget> listUi = [
      Text(
        "Lecciones",
        style: TextStyle(
            color: isDarkTheme ? Colors.white : Color(0xFF333333),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      )
    ];

    if (vertical)
      listUi.addAll(lessonListItems(lessonList));
    else
      listUi.add(Container(
        width: screenWidth,
        height: vertical ? lessonList.length * itemHeight : itemHeight,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: lessonListItems(lessonList),
          scrollDirection: vertical ? Axis.vertical : Axis.horizontal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ));

    return listUi;
  }

  List<Widget> lessonListItems(List<Lesson> lessonList) {
    List<Widget> lessonItemList = [];
    lessonList.forEach((lesson) {
      lessonItemList.add(LessonItem(
        lesson: lesson,
        vertical: vertical,
        course: lesson.course,
      ));
    });

    return lessonItemList;
  }
}
