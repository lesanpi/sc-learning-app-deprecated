import 'package:e_learning_sc/model/Content.dart';
import 'package:flutter/material.dart';

class Guide extends Content{
    String url;
    String img_url;

    Guide({required title, required this.url, required this.img_url}) : super(title: title);

}