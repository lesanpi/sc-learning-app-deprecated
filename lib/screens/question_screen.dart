import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Question.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:e_learning_sc/screens/result_screen.dart';
import 'package:e_learning_sc/widgets/question_option.dart';
import 'package:e_learning_sc/widgets/quiz_medal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionScreen extends StatefulWidget {
  Quiz quiz;
  int questionNum;
  int corrects;

  QuestionScreen({required this.quiz, this.questionNum = 0, this.corrects = 0});

  @override
  State<StatefulWidget> createState() {
    return QuestionScreenState();
  }
}

class QuestionScreenState extends State<QuestionScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _quizStatus;

  int option_selected = 0;

  Future<void> _updateQuizStatus() async {
    final SharedPreferences prefs = await _prefs;
    final int quizStatus = (prefs.getInt(widget.quiz.id) ?? 0) + 1;
    print(quizStatus);

    setState(() {
      _quizStatus = prefs.setInt(widget.quiz.id, 1).then((bool success) {
        return quizStatus;
      });

      print(_quizStatus);
    });
    print(quizStatus);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
              child: Container(
            width: screenWidth,
            height: screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo_black.png'),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(children: [
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: QuizMedal(
                          size: 60,
                          background_color: App.myGrey,
                          emoji: "❔",
                          emojiSize: 25,
                        )),
                    Flexible(
                      child: Text(
                        widget.quiz.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ]),
                ),
                Container(
                  width: screenWidth,
                  child: Text(
                    widget.quiz.questions[widget.questionNum].question,
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                InkWell(
                  child: QuestionOption(
                      option:
                          widget.quiz.questions[widget.questionNum].option_1,
                      selected: option_selected == 1),
                  onTap: () {
                    setState(() {
                      option_selected = 1;
                    });
                  },
                ),
                InkWell(
                  child: QuestionOption(
                      option:
                          widget.quiz.questions[widget.questionNum].option_2,
                      selected: option_selected == 2),
                  onTap: () {
                    setState(() {
                      option_selected = 2;
                    });
                  },
                ),
                InkWell(
                  child: QuestionOption(
                      option:
                          widget.quiz.questions[widget.questionNum].option_3,
                      selected: option_selected == 3),
                  onTap: () {
                    setState(() {
                      option_selected = 3;
                    });
                  },
                ),
                InkWell(
                  child: QuestionOption(
                      option:
                          widget.quiz.questions[widget.questionNum].option_4,
                      selected: option_selected == 4),
                  onTap: () {
                    setState(() {
                      option_selected = 4;
                    });
                  },
                ),
                Container(
                  width: screenWidth,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(left: screenWidth / 2),
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: 60,
                      decoration: BoxDecoration(
                        color:
                            option_selected == 0 ? Colors.black12 : App.myBlack,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            blurRadius: 0.1,
                            spreadRadius: 0.1,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          widget.questionNum == widget.quiz.questions.length - 1
                              ? "TERMINAR"
                              : "SIGUIENTE",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (option_selected != 0) {
                        int _corrects = widget
                                    .quiz
                                    .questions[widget.questionNum]
                                    .correctOption ==
                                option_selected
                            ? widget.corrects + 1
                            : widget.corrects;

                        if (widget.questionNum + 1 ==
                            widget.quiz.questions.length) {
                          if (widget.corrects == widget.quiz.questions.length)
                            _updateQuizStatus();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                    quiz: widget.quiz,
                                    corrects: _corrects,
                                    courseId: widget.quiz.id.substring(
                                        0, widget.quiz.id.length - 3))),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionScreen(
                                    quiz: widget.quiz,
                                    questionNum: widget.questionNum + 1,
                                    corrects: _corrects)),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          )),
        ),
        onWillPop: () async {
          setState(() {});

          return true;
        });
  }
}
