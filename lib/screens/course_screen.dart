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

class CourseScreen extends StatelessWidget{

  Course course;

  CourseScreen({required this.course});

  @override
  Widget build(BuildContext context) {

    return courseScreen(context);
  }

  Widget courseScreen(BuildContext context){
    return Scaffold(
      body: courseScreenUI(context),
    );
  }

  Widget courseScreenUI(BuildContext context){
    return Center(
      child: ListView(
        children: [
          Container(
              height: 100,
              decoration: const BoxDecoration(
                  color: App.primary_color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(40)
                  )
              ),
              padding: EdgeInsets.only(
                  left: 30,
                  right: 20
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Container(
                      child: Icon(Icons.arrow_back_ios_sharp,
                        color: Colors.white, size: 30,),
                      margin: EdgeInsets.only(
                        right: 10
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    }
                  ),
                  Text(
                    course.title,
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
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
              bottom: 0
            ),
            child: Text(
              course.description,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,

              ),
              textAlign: TextAlign.justify,
            ),
          ),
          ContentList(contentList: course.content_list, course: course,)
        ],
      ),
    );
  }

}