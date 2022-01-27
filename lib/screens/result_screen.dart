import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  Quiz quiz;
  int corrects;
  String courseId;

  ResultScreen(
      {required this.quiz, required this.corrects, required this.courseId});

  @override
  State<StatefulWidget> createState() {
    return ResultScreenState();
  }
}

class ResultScreenState extends State<ResultScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _courseProgress;
  late Future<int> _quizProgress;

  @override
  void initState() {
    super.initState();
    _quizProgress = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(widget.quiz.id) ?? 0);
    });
    _courseProgress = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(widget.courseId) ?? 0);
    });
  }

  Future<void> _updateQuizStatus() async {
    final SharedPreferences prefs = await _prefs;
    final int quizProgress = (prefs.getInt(widget.quiz.id) ?? 0) + 1;

    setState(() {
      _quizProgress = prefs.setInt(widget.quiz.id, 1).then((bool success) {
        return quizProgress;
      });
    });
  }

  Future<void> _updateCourseStatus() async {
    final SharedPreferences prefs = await _prefs;
    final int courseProgress = (prefs.getInt(widget.courseId) ?? 0) + 1;

    setState(() {
      _courseProgress =
          prefs.setInt(widget.courseId, courseProgress).then((bool success) {
        return courseProgress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final logo =
        isDarkTheme ? 'assets/logo_white.png' : 'assets/logo_black.png';

    var resultColor;
    if (widget.corrects / widget.quiz.questions.length == 1)
      resultColor = isDarkTheme ? App.gold : Colors.blueAccent;
    else
      resultColor = isDarkTheme ? Colors.white : App.myBlack;

    return Scaffold(
      backgroundColor: isDarkTheme ? Colors.grey.shade900 : Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/second');
          return false;
        },
        child: SafeArea(
          child: FutureBuilder(
            future: _courseProgress,
            builder: (BuildContext context, AsyncSnapshot<int> snapshotCourse) {
              if (snapshotCourse.connectionState == ConnectionState.done) {
                return FutureBuilder(
                  future: _quizProgress,
                  builder:
                      (BuildContext context, AsyncSnapshot<int> snapshotQuiz) {
                    if (snapshotQuiz.connectionState == ConnectionState.done) {
                      print(widget.courseId);
                      print("Course ${snapshotCourse.data}");
                      print("Quiz ${snapshotQuiz.data}");

                      if (snapshotQuiz.data == 0) {
                        if (widget.corrects == widget.quiz.questions.length) {
                          _updateCourseStatus();
                          _updateQuizStatus();
                        }
                      }

                      return Container(
                        width: screenWidth,
                        height: screenHeight,
                        // color: Colors.white,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(logo),
                                      fit: BoxFit.cover)),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                            Container(
                              child: Text(
                                "Resultados del Quiz",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  // color: Color(0xFF333333),
                                ),
                              ),
                              margin: EdgeInsets.only(bottom: 40),
                            ),
                            Container(
                              child: CircularPercentIndicator(
                                radius: 200.0,
                                lineWidth: 20.0,
                                animation: true,
                                percent: widget.corrects /
                                    widget.quiz.questions.length,
                                center: Container(
                                    width: 135,
                                    height: 135,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(250)),
                                        border: Border.all(color: resultColor)),
                                    child: Center(
                                      child: Text(
                                        "${(100 * widget.corrects / widget.quiz.questions.length).round()}%",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w600,
                                          // color: Colors.black,
                                        ),
                                      ),
                                    )),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: resultColor,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(250)),
                                border: Border.all(color: resultColor),
                              ),
                              padding: EdgeInsets.all(15),
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "¡Tu Puntuación!",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                        // color: Color(0xFF333333),
                                      ),
                                    ),
                                    Text(
                                      "${widget.quiz.title}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        // color: Colors.black45,
                                      ),
                                    ),
                                    Container(
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: resultColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(70))),
                                          width: screenWidth * 0.75,
                                          height: 70,
                                          child: Center(
                                            child: Text(
                                              "Volver al Inicio",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: isDarkTheme
                                                      ? Colors.black
                                                      : Colors.white
                                                  // color: Colors.white,R
                                                  ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(context, '/');
                                        },
                                      ),
                                      margin: EdgeInsets.only(top: 40),
                                    )
                                  ],
                                ))
                          ],
                        )),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
