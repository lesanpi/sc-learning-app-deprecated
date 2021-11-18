import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:e_learning_sc/screens/quizes_screen.dart';
import 'package:e_learning_sc/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class CourseQuizMenuItem extends StatelessWidget{

  CourseQuiz courseQuiz;

  CourseQuizMenuItem({required this.courseQuiz});



  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30
        ),
        child: Column(
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15
                ),
                decoration: BoxDecoration(
                    color: App.primaryColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(courseQuiz.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),
                    Text(courseQuiz.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ProgressBar(total: courseQuiz.quizes.length, id: courseQuiz.id, width: screenWidth - 60 - 40,),

                  ],
                ),

              ),
              Container(
                width: screenWidth,
                height: 50,
                decoration: BoxDecoration(
                  color: App.darkBlue,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Text(
                      "${courseQuiz.quizes.length} Quiz/es",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              )
            ]
        ),
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizesScreen(courseQuiz: courseQuiz,)),
        );
      },
    );
  }


}