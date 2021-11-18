import 'dart:convert';

import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:e_learning_sc/model/Question.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:e_learning_sc/widgets/course_quiz_menu_item.dart';
import 'package:e_learning_sc/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameMenuScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return gameMenuScreen(context);
  }

  Widget gameMenuScreen(BuildContext context){
    return Scaffold(
      body: gameMenuScreenUI(context),
    );
  }

  Widget gameMenuScreenUI(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;
    double headerHeight = 140;

    return FutureBuilder(

        future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());

          return Center(
              child: Column(
                children: [
                  Container(
                      height: headerHeight,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: const BoxDecoration(
                          color: App.primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(30)
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
                            "Nuestros cursos",//"Aprende sobre matematicas",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              //fontFamily:
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                    height: screenHeight - headerHeight - 100,
                    child: snapshot.connectionState != ConnectionState.done ? Container()
                        :
                    ListView(
                      children: courseQuizMenuItemList(App.courseQuizList(data["quizes"])),
                      scrollDirection: Axis.vertical,
                    ),
                  )
                ],
              )
          );
        }


    );

  }

  List<Widget> courseQuizMenuItemList(List<CourseQuiz> courseQuizList){

    List<Widget> courseQuizItems = [];
    courseQuizList.forEach((courseQuiz) {
      courseQuizItems.add(CourseQuizMenuItem(courseQuiz: courseQuiz));
    });

    return courseQuizItems;
  }
}