import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Content.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/widgets/content_list.dart';
import 'package:e_learning_sc/widgets/course_list.dart';
import 'package:e_learning_sc/widgets/guide_list.dart';
import 'package:e_learning_sc/widgets/lesson_list.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  Course course;

  CourseScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return courseScreen(context);
  }

  Widget courseScreen(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: courseScreenUI(context)),
    );
  }

  Widget courseScreenUI(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
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
                spreadRadius: 0.1,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: Container(
                    child: const Text(
                      "👈",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF333333),
                        //Colors.white,
                        fontWeight: FontWeight.bold,
                        //fontFamily:
                      ),
                      textAlign: TextAlign.center,
                    ),
                    /*Icon(
                            Icons.arrow_back_rounded, // arrow_back_ios_sharp
                            color: App.myBlack, size: 30,
                          ),*/
                    margin: EdgeInsets.only(right: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Text(
                course.title, //"Aprende sobre matematicas",
                style: const TextStyle(
                  fontSize: 21,
                  color: App.myBlack,
                  //Colors.white,
                  fontWeight: FontWeight.w900,
                  //fontFamily:
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo_black.png'),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
        Container(
          height: screenHeight - 111,
          child: ListView(
            children: [
              Container(
                width: screenWidth,
                height: 100,
                child: Center(
                  child: Text(
                    course.emoji,
                    style: const TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      //fontFamily:
                    ),
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 0),
                child: Text(
                  course.description,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              ContentList(
                contentList: course.contentList,
                course: course,
              )
            ],
          ),
        )
      ],
    );
  }
}
