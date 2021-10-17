import 'package:e_learning_sc/model/Content.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/guide_item.dart';
import 'package:e_learning_sc/widgets/lesson_item.dart';
import 'package:e_learning_sc/widgets/lesson_item_horizontal.dart';
import 'package:e_learning_sc/widgets/lesson_item_vertical.dart';
import 'package:flutter/material.dart';

class ContentList extends StatelessWidget{

  double screenWidth = 0;
  double itemHeight = 0;
  bool mini;
  List<Content> contentList;
  Course course;

  ContentList({required this.course, this.contentList = const [], this.mini = false});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    this.screenWidth = screenWidth;

    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    this.screenWidth = screenHeight;


    return Container(
      margin: EdgeInsets.only(
        left: this.mini ? 0 : 20,
        right: this.mini ? 0 : 20,
        top: mini ? 15 : 30,
      ),
      child: mini ?
          Column(
            children: [
              Container(
                child: Text("Lecciones", style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                ),
                margin: EdgeInsets.only(
                    left: this.mini ? 20 : 0,
                  bottom: 10
                ),
                width: screenWidth,
              ),
              Container(
                child: MediaQuery.removePadding(context: context,
                    removeTop: true,
                    child: ListView(
                      children: listUi(contentList),
                    )
                ),
                width: screenWidth,
                height: screenHeight - 400 - 40 - 10
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listUi(contentList)
      ),
    );
  }

  List<Widget> listUi(List<Content> contentList){

    List<Widget> listUi = [
      mini ? Container(
        height: 0,
      ) : Container(
        child: Text("Lecciones", style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        ),
        margin: EdgeInsets.only(
          left: this.mini ? 20 : 0
        ),
        width: screenWidth,
      )
    ];
    double height = 0;
    List<Widget> contentItems = [];
    List items = contentListItems(contentList);

    height = items[0];
    contentItems = items[1];

    listUi.add(Container(
      width: screenWidth ,
      height: height,
      margin: EdgeInsets.only(
          top: mini ? 0 : 10
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contentItems,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ));

    return listUi;
  }

  List contentListItems(List<Content> contentList){

    double height = 0;
    List<Widget> contentListWidget = [];
    contentList.forEach((content) {
      if (content is Lesson){
        height += mini ? 81 : 190;
        contentListWidget.add(LessonItem(lesson: content as Lesson, mini: this.mini, course: course,));
      }
      else if(content is Guide){
        height += mini ? 81 : 70;
        contentListWidget.add(GuideItem(guide: content as Guide, mini: this.mini,));
      }
    });

    return [height, contentListWidget];
  }


}