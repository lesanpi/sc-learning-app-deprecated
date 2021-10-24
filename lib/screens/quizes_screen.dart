import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:e_learning_sc/widgets/back_button.dart';
import 'package:e_learning_sc/widgets/quiz_item.dart';
import 'package:e_learning_sc/widgets/simple_progress_bar.dart';
import 'package:flutter/material.dart';

class QuizesScreen extends StatelessWidget{

  CourseQuiz courseQuiz;

  QuizesScreen({required this.courseQuiz});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 80
              ),
              child: ListView(
                children: listQuizesWidget(),
              ),
            ),
            Container(
              width: screenWidth,
              height: 80,
              child: Row(
                children: [
                  MyBackButton(size: 30, color: Colors.black,),
                  Text(
                    "Quizes",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                        fontSize: 25
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),

            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: App.primary_color,
        toolbarHeight: 0,
      ),
    );
  }

  List<Widget> listQuizesWidget(){

    List<Widget> quizesWidgets = [];
    courseQuiz.quizes.forEach((quiz) {
      quizesWidgets.add(QuizItem(quiz: quiz,));
    });

    return quizesWidgets;

  }

}