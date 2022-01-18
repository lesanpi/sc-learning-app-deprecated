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
      body: SafeArea(
        child: gameMenuScreenUI(context),
      ),
      appBar: AppBar(
        backgroundColor: App.myBlack,
        toolbarHeight: 0,
      ),
    );
  }

  Widget gameMenuScreenUI(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double headerHeight = 100;//120;

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
                            spreadRadius: 0.5,
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      //: EdgeInsets.all(10),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "🧠",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF333333),
                                //Colors.white,
                                fontWeight: FontWeight.bold,
                                //fontFamily:
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "¡Ponte a Prueba!",//"Aprende sobre matematicas",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF333333),
                                //Colors.white,
                                fontWeight: FontWeight.w900,
                                //fontFamily:
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "🧠",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF333333),
                                //Colors.white,
                                fontWeight: FontWeight.bold,
                                //fontFamily:
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                  ),
                  Container(
                    height: screenHeight - headerHeight - 155,
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
    int i = 0;
    List<Color> colors = [App.primaryColor, App.gold, Colors.lightGreen, Colors.redAccent, Colors.indigoAccent];
    List<String> emojis = ["🦁", "🦒", "🐊", "🦜", "🐳"];

    courseQuizList.forEach((courseQuiz) {
      courseQuizItems.add(CourseQuizMenuItem(courseQuiz: courseQuiz, color: colors[i], emoji: emojis[i],));
      i++;
    });

    return courseQuizItems;
  }
}