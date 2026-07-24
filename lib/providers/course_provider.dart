import 'package:flutter/material.dart';
import 'package:almentor_mini_player/services/course_service.dart';
import 'package:almentor_mini_player/models/course_model.dart';
import 'package:almentor_mini_player/services/progress_service.dart';
class CourseProvider extends ChangeNotifier {
    final CourseService courseService = CourseService();
    final ProgressService progressService = ProgressService();
    List<CourseModel> _courses = [];
    final Map<String, double> _progress = {};
    List<CourseModel> get courses => _courses;
    Map<String, double> get progress => _progress;
    Future<void> loadCourses() async {
        _progress.clear();
        _courses = await courseService.loadCourses();
        for (final course in _courses) {
            _progress[course.id] =
            await progressService.getProgress(
                course.id,
                course.durationSeconds,
            );
        }
        notifyListeners();
    }
}