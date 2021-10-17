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
      body: gameMenuScreenUI(context),
    );
  }

  Widget gameMenuScreenUI(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;
    double headerHeight = 140;

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
                  color: App.primary_color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(30)
                  )
              ),
              padding: EdgeInsets.only(
                  left: 30,
                  right: 20
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nuestros cursos",//"Aprende sobre matematicas",
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
            height: screenHeight - headerHeight - 100,
            child: ListView(
              children: courseQuizMenuItem(context),
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      )
    );
  }

  List<Widget> courseQuizMenuItem(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;

    List<Question> questions_ex = [
      Question(question: "¿Cuanto es 2 + 2?", option_1: "1", option_2: "2", option_3: "3", option_4: "Pez", correctOption: 4)
    ];
    List<Quiz> quizes_ex = [
      Quiz(name: "V", questions: questions_ex)
    ];
    CourseQuiz courseQuiz_ex = CourseQuiz(name: "5to Año", id: "ae1e2", description: "Vectores, derivadas e integrales",
      quizes: quizes_ex
    );

    return [
      CourseQuizMenuItem(courseQuiz: courseQuiz_ex,),
      CourseQuizMenuItem(courseQuiz: courseQuiz_ex,),
      CourseQuizMenuItem(courseQuiz: courseQuiz_ex,),
      CourseQuizMenuItem(courseQuiz: courseQuiz_ex,),
      CourseQuizMenuItem(courseQuiz: courseQuiz_ex,),

    ];
  }
}