import 'package:e_learning_sc/model/Content.dart';
import 'package:flutter/material.dart';

class Course{
  final String title;
  final String description;
  final String mini_description;
  final List<Content> content_list;

  Course({required this.title, required this.mini_description, required this.description, required this.content_list});
}