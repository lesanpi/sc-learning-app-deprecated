import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:e_learning_sc/widgets/back_button.dart';
import 'package:e_learning_sc/widgets/quiz_item.dart';
import 'package:e_learning_sc/widgets/simple_progress_bar.dart';
import 'package:flutter/material.dart';

class QuizesScreen extends StatelessWidget {
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
              padding: EdgeInsets.only(left: 20, right: 20, top: 80),
              child: ListView(
                children: listQuizesWidget(),
              ),
            ),
            Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  //App.primaryColor,
                  borderRadius: BorderRadius.only(
                      //bottomLeft: Radius.circular(30),
                      //bottomRight: Radius.circular(30)
                      ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 0.1,
                      spreadRadius: 0.1,
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                //: EdgeInsets.all(10),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          child: Container(
                            child: Text(
                              "👈",
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xFF333333),
                                //Colors.white,
                                fontWeight: FontWeight.bold,
                                //fontFamily:
                              ),
                              textAlign: TextAlign.center,
                            ),
                            /*Icon(
                            Icons.arrow_back_rounded, // arrow_back_ios_sharp
                            color: App.myBlack, size: 30,
                          ),*/
                            margin: EdgeInsets.only(right: 0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        "Quizes", //"Aprende sobre matematicas",
                        style: TextStyle(
                          fontSize: 21,
                          color: App.myBlack,
                          //Colors.white,
                          fontWeight: FontWeight.w900,
                          //fontFamily:
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/logo_black.png'),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> listQuizesWidget() {
    List<Widget> quizesWidgets = [];
    courseQuiz.quizes.forEach((quiz) {
      quizesWidgets.add(QuizItem(
        quiz: quiz,
      ));
    });

    return quizesWidgets;
  }
}
