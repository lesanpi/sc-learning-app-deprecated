import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Course.dart';
import 'package:e_learning_sc/screens/course_screen.dart';
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget{

  Course course;
  Color color;
  String emoji;

  CourseItem({required this.course, this.color = App.primaryColor, this.emoji = "🦁"});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: color,//App.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.4),
                blurRadius: 1,
                spreadRadius: 0.1,
              )
            ]
        ),
        height: 30,
        width: screenWidth * 2 / 3,
        margin: EdgeInsets.only(
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  //fontFamily:
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 0),
            ),
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
              course.miniDescription,
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
            right: 30
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