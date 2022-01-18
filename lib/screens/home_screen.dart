import 'dart:convert';

import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/course_list.dart';
import 'package:e_learning_sc/widgets/guide_list.dart';
import 'package:e_learning_sc/widgets/lesson_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: homeScreen(context),
      appBar: AppBar(
        backgroundColor: App.myBlack,
        toolbarHeight: 0,
      ),
    );
  }

  Widget homeScreen(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(

      future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
      builder: (context, snapshot){
        var data = json.decode(snapshot.data.toString());

        List<Course> course_list = [];
        List<Lesson> lesson_list = [];
        List<Guide> guide_list = [];

        if (snapshot.connectionState != ConnectionState.waiting) {
          course_list = App.courseList(data["courses"]);
          for (int i = 0; i < course_list.length; i++) {
            for (int j = 0; j < course_list[i].contentList.length; j++) {
              if (course_list[i].contentList[j] is Lesson)
                lesson_list.add(course_list[i].contentList[j] as Lesson);
              else
                guide_list.add(course_list[i].contentList[j] as Guide);
            }
          }

          lesson_list.shuffle();
          guide_list.shuffle();
          lesson_list = lesson_list.sublist(0, lesson_list.length < 5 ? lesson_list.length : 5);
          guide_list = guide_list.sublist(0, guide_list.length < 3 ? guide_list.length : 3);
        }



        return Column(
          children: [
            Container(
                height: 150,//225,
                width: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,//App.primaryColor,
                  borderRadius: BorderRadius.only(
                    //bottomRight: Radius.circular(60), //90,
                    //bottomLeft: Radius.circular(60)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 0.3,
                      spreadRadius: 0.3,
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                margin: EdgeInsets.only(
                    top: 0,
                    left: 0,
                    right: 0
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/logo_black.png'),
                              fit: BoxFit.cover
                          )
                      ),
                      margin: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Aprende matemáticas, ",
                          style: TextStyle(
                            fontSize: 20,
                            color: //Colors.white,
                            Color(0xFF999999),
                            fontWeight: FontWeight.w600,
                            //fontFamily:
                          ),
                        ),
                        Text(
                          "con ASOCIARTE 👌",//Aprende sobre matematicas",
                          style: TextStyle(
                            fontSize: 30,//35,
                            color: Color(0xFF333333),
                            //Colors.white,
                            fontWeight: FontWeight.w900,
                            //fontFamily:
                          ),
                        ),

                      ],
                    )
                  ],
                )

            ),
            Container(
              //color: Colors.red,
              height: screenHeight - 281,
              child: ListView(
                children: <Widget>[
                  snapshot.connectionState == ConnectionState.waiting ? Container() : CourseList(course_list: App.courseList(data["courses"]),),
                  snapshot.connectionState == ConnectionState.waiting ? Container() : LessonList(lessonList: lesson_list,),
                  snapshot.connectionState == ConnectionState.waiting ? Container() : GuideList(guideList: guide_list,),

                ],
              ),
            )

          ],
        );
      },
    );

  }
}