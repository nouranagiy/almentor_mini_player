import 'package:flutter/material.dart';
import 'package:almentor_mini_player/services/course_service.dart';
import 'package:almentor_mini_player/models/course_model.dart';
class CourseProvider extends ChangeNotifier {
    final CourseService courseService = CourseService();
    List<CourseModel> _courses = [];
    List<CourseModel> get courses => _courses;
    Future<void> loadCourses() async {
        _courses = await courseService.loadCourses();
        notifyListeners();
    }
}