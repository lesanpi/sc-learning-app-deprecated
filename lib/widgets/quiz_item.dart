import 'package:e_learning_sc/model/App.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:e_learning_sc/screens/question_screen.dart';
import 'package:e_learning_sc/widgets/quiz_medal.dart';
import 'package:e_learning_sc/widgets/simple_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizItem extends StatefulWidget{

  Quiz quiz;

  QuizItem({required this.quiz});

  @override
  State<StatefulWidget> createState() {
    return QuizItemState();
  }

}

class QuizItemState extends State<QuizItem>{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _quizProgress;

  @override
  void initState() {
    super.initState();
    _quizProgress = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(widget.quiz.id) ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = 30;

    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionScreen(quiz: widget.quiz, questionNum: 0, corrects: 0)),
        );
      },
      child: FutureBuilder(
        future: _quizProgress,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
              return Container();
            default:

              return Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    color: snapshot.data! > 0 ? App.gold : Colors.black12,
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
                          QuizMedal(size:70, emoji: snapshot.data! > 0 ? "🥇":"✖‍"),
                          // ⛔
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.quiz.title,
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
                    SimpleProgressBar(completed: snapshot.data! > 0 ? 1 : 0,),
                    Container(
                      width: screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        color: App.darkBlue,
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(radius)
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Text(
                          "${widget.quiz.questions.length} Pregunta/s",
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

        },
      ),

    );
  }

}