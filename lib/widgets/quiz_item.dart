import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:e_learning_sc/widgets/quiz_medal.dart';
import 'package:e_learning_sc/widgets/simple_progress_bar.dart';
import 'package:flutter/material.dart';

class QuizItem extends StatelessWidget{

  Quiz quiz;

  QuizItem({required this.quiz});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = 30;

    return Container(
      width: screenWidth,
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
      margin: EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal:20),
            child: Row(
              children: [
                QuizMedal(size:70),
                Expanded(
                  child: Container(
                    child: Text(
                      quiz.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 21
                      ),
                      maxLines: 2,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                )
              ],
            ),
          ),
          SimpleProgressBar(completed: 0,),
          Container(
            width: screenWidth,
            height: 50,
            decoration: BoxDecoration(
              color: App.dark_blue,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(radius)
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                "${quiz.questions.length} Pregunta/s",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}