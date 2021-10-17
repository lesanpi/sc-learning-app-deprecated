import 'package:e_learning_sc/model/Content.dart';
import 'package:flutter/material.dart';

class Lesson extends Content{

  final String description;
  String video_url;
  String image_url;

  Lesson({required title, required this.description,required this.video_url,required this.image_url}) : super(title: title);
}