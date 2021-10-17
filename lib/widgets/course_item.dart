import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/screens/course_screen.dart';
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget{

  Course course;

  CourseItem({required this.course});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: App.primary_color,
            borderRadius: BorderRadius.all(Radius.circular(40))
        ),
        height: 30,
        width: screenWidth * 2 / 3,
        margin: EdgeInsets.only(
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              course.title,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                //fontFamily:
              ),
            ),
            Text(
              course.mini_description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                //fontFamily:
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        padding: EdgeInsets.only(
            left: 30,
            right: 20
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseScreen(course: course,)),
        );
      },
    );
  }

}