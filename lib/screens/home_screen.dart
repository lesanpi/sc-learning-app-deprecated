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


  List<Lesson> lessonList = [Lesson(
      title: "Escalares, vectores y matrices",
      description: "Aprende acerca de los escalares, los vectores y las matrices",
      video_url: "",
      image_url: ""
  ),
    Lesson(
        title: "Escalares, vectores y matrices",
        description: "Aprende acerca de los escalares, los vectores y las matrices",
        video_url: "",
        image_url: ""
    ),
    Lesson(
        title: "Escalares, vectores y matrices",
        description: "Aprende acerca de los escalares, los vectores y las matrices",
        video_url: "",
        image_url: ""
    ),
    Lesson(
        title: "Escalares, vectores y matrices",
        description: "Aprende acerca de los escalares, los vectores y las matrices",
        video_url: "",
        image_url: ""
    )];

  List<Guide> guideList = [Guide(title: "Escalares, vectores y matrices", url: "", img_url: "")];



  @override
  Widget build(BuildContext context) {

    return homeScreen(context);
  }

  Widget homeScreen(BuildContext context){

    App myApp = App();
    
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
      builder: (context, snapshot){
        var data = json.decode(snapshot.data.toString());

        return Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: ListView(
            children: <Widget>[
              Container(
                  height: 225,
                  decoration: const BoxDecoration(
                      color: Color(0xFF2ed1c4),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(90)
                      )
                  ),
                  padding: EdgeInsets.only(
                      left: 30,
                      right: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data["description"],//"Aprende sobre matematicas",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //fontFamily:
                        ),
                      ),
                      Text(
                        "con ASOCIARTE",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          //fontFamily:
                        ),
                      )
                    ],
                  )
              ),
              CourseList(course_list: myApp.courseList(data["courses"]),),
              LessonList(lessonList: lessonList, course: Course(title: "", description: "", mini_description: "", content_list: []),),
              GuideList(guideList: guideList,),

            ],
          ),
        );
      },
    );

  }
}