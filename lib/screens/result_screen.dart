import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget{

  Quiz quiz;
  int corrects;
  String courseId;

  ResultScreen({required this.quiz, required this.corrects, required this.courseId});

  @override
  State<StatefulWidget> createState() {
      return ResultScreenState();
  }

}

class ResultScreenState extends State<ResultScreen>{
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
      _courseProgress = prefs.setInt(widget.courseId, courseProgress).then((bool success) {
        return courseProgress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(

      future: _courseProgress,
      builder: (BuildContext context, AsyncSnapshot<int> snapshotCourse) {
        if (snapshotCourse.connectionState == ConnectionState.done){
          return FutureBuilder(
            future: _quizProgress,
            builder: (BuildContext context, AsyncSnapshot<int> snapshotQuiz){
                if(snapshotQuiz.connectionState == ConnectionState.done){
                  print(widget.courseId);
                  print("Course ${snapshotCourse.data}");
                  print("Quiz ${snapshotQuiz.data}");

                  if (snapshotQuiz.data == 0){
                      if (widget.corrects == widget.quiz.questions.length){
                        _updateCourseStatus();
                        _updateQuizStatus();

                      }
                  }

                  return Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: App.primaryColor,
                    child: Center(
                      child: Text(
                        "${widget.corrects}/${widget.quiz.questions.length}",
                      ),
                    ),
                  );
                }else{
                  return Container();
                }
            },
          );
        }else {
          return Container();
        }
      },
    );

  }

}