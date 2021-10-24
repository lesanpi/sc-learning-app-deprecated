import 'dart:convert';
import 'package:e_learning_sc/model/Content.dart';
import 'package:e_learning_sc/model/CourseQuiz.dart';
import 'package:e_learning_sc/model/Guide.dart';
import 'package:e_learning_sc/model/Lesson.dart';
import 'package:e_learning_sc/model/Question.dart';
import 'package:e_learning_sc/model/Quiz.dart';
import 'package:flutter/material.dart';
import 'Course.dart';

class App{

  static const MaterialAccentColor primary_color = Colors.blueAccent;
  static const Color option_color = Color(0xFF2ed1c4);
  static const Color gold = Color.fromRGBO(255, 185, 44, 1);
  static const Color dark_blue = Color(0xFF40587c);
  static const Color green_progress = Color(0xFF98ca3f);

  var _data;

  static List<Course> courseList(var data){
    List<Course> _courseList = [];
    for(int i = 0; i < data.length; i++){

      _courseList.add(Course(
          title: data[i]["title"], 
          description: data[i]["description"],
          mini_description: data[i]["mini_description"],
          content_list: contentList(data[i]["content"])
      ));
    }

    return _courseList;
  }

  static List<Content> contentList(var dataContent){
    List<Content> _contentList = [];

    for(int i = 0; i < dataContent.length; i++){
      if (dataContent[i]["type"] == "lesson")
        _contentList.add(Lesson(
          title: dataContent[i]["title"],
          description: dataContent[i]["description"],
          image_url: dataContent[i]["img_url"],
          video_url: dataContent[i]["url"]
        ));
      else
        _contentList.add(Guide(
            title: dataContent[i]["title"],
            img_url: dataContent[i]["img_url"],
            url: dataContent[i]["url"]
        ));
    }

    return _contentList;
  }

  static List<CourseQuiz> courseQuizList(var dataCourseQuizes){
    List<CourseQuiz> _courseQuizList = [];

    for(int i = 0; i < dataCourseQuizes.length; i++){

      _courseQuizList.add(
          CourseQuiz(
              id: dataCourseQuizes[i]["id"], 
              name: dataCourseQuizes[i]["title"], 
              description: dataCourseQuizes[i]["description"], 
              quizes: App.quizesList(dataCourseQuizes[i]["quizes"])
          )
      );
    }
    
    return _courseQuizList;
  }

  static List<Quiz> quizesList(var dataQuizes){
    List<Quiz> _quizes = [];
    for(int i = 0; i < dataQuizes.length; i++){
      _quizes.add(Quiz(id: dataQuizes[i]["id"], title: dataQuizes[i]["title"], questions: App.questions(dataQuizes[i]["questions"])));
    }
    
    return _quizes;
  }
  
  static List<Question> questions(var dataQuiz){
    List<Question> _questions = [];
    for(int i = 0; i < dataQuiz.length; i++){
      _questions.add(
          Question(
              question: dataQuiz[i]["question"],
              option_1: dataQuiz[i]["option_1"],
              option_2: dataQuiz[i]["option_2"],
              option_3: dataQuiz[i]["option_3"],
              option_4: dataQuiz[i]["option_4"],
              correctOption: dataQuiz[i]["correct_option"]
          )
      );
    }
    
    return _questions;
  }

}