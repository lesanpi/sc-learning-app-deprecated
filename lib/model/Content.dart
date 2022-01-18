import 'package:e_learning_sc/model/Course.dart';
import 'package:flutter/material.dart';

class Content{
  String title;
  Course course = Course(title: "", description: "", miniDescription: "", contentList: [], emoji: "");

  Content({required this.title});

  void set_course(Course course){
    this.course = course;
  }
}