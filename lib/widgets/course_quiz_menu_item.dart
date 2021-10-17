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
        height: 125,
        width: screenWidth,
        margin: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 25
        ),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 15
              ),
            ),
            ProgressBar(total: courseQuiz.quizes.length, id: courseQuiz.id)
          ],
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