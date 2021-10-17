import 'package:e_learning_sc/model/Lesson.dart';
import 'package:flutter/material.dart';

class LessonItemVertical extends StatelessWidget{

  Lesson lesson;
  bool mini;

  LessonItemVertical({required this.lesson, this.mini = false});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    double itemHeight = 210;
    if (this.mini)
      return Container(
        width: screenWidth,
        height: 80,
        margin: EdgeInsets.only(
          top: 1,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 1,
                spreadRadius: 0.1,
              )
            ]

        ),
        child: Row(
          children: [
            InkWell(
              child: Icon(
                Icons.play_circle_fill,
                color: Color(0xFF2ed1c4),
                size: 35,
              ),
            ),
            Container(
              child: Text(lesson.title, style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 15
              ),),
              margin: EdgeInsets.symmetric(
                horizontal: 10
              ),
            )

          ],
        ),

      );

    return Container(
      width: screenWidth, margin: EdgeInsets.only(
      bottom: 10,
      top: 10,
    ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 1,
              spreadRadius: 0.1,
            )
          ]

      ),
      child: Row(
        children: [
          Container(
            width: (screenWidth * 3 / 8) - 10,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 1,
                    spreadRadius: 0.1,
                  )
                ]
            ),
          ),
          Container(
            //color: Colors.green,
            height: 150,
            width: ( screenWidth * 5 / 8 ) - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(lesson.title, maxLines: 2, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 17
                ), overflow: TextOverflow.ellipsis,),
                Text(lesson.description, maxLines: 4, style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black54,
                  fontSize: 16
                ), overflow: TextOverflow.ellipsis,)
              ],
            ),
            padding: EdgeInsets.all(10),
          )
        ],
      ),
    );
  }

}