import 'package:almentor_mini_player/models/course_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
class CourseService {
  Future<List<CourseModel>> loadCourses() async {
    final String response = await rootBundle.loadString('assets/data/courses.json');
    final Map<String, dynamic> json = jsonDecode(response);
    final List<dynamic> courses = json["courses"];
    return courses.map((course) => CourseModel.fromJson(course)).toList();
  }
}