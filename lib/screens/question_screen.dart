import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Question.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget{

  List<Question> questions;
  int questionNum;

  QuestionScreen({required this.questions, this.questionNum = 0});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

      return Scaffold(
        body: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth,
                  color: Colors.black12,
                  child: Text(
                    questions[questionNum].question,
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
        appBar: AppBar(
          backgroundColor: App.primary_color,
          toolbarHeight: 0,
        ),
      );
  }

}

