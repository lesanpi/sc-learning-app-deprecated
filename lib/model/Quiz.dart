import 'package:e_learning_sc/model/Question.dart';

class Quiz{
  String name;
  String description;
  List<Question> questions;

  Quiz({required this.name, required this.questions, this.description = ""});
}