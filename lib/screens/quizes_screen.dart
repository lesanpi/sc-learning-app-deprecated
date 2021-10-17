import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:flutter/material.dart';

class QuizesScreen extends StatelessWidget{

  CourseQuiz courseQuiz;

  QuizesScreen({required this.courseQuiz});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = 30;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30
        ),
        child: ListView(
          children: [
            Container(
              width: screenWidth,
              height: 150,
              decoration: BoxDecoration(
                color: App.primary_color,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      blurRadius: 1,
                      spreadRadius: 0.1,
                    )
                  ]
              ),
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: 100,
                  ),

                  Container(
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(radius)
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}