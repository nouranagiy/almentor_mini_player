import 'package:flutter/material.dart';
import '../models/course_model.dart';
class CourseCard extends StatelessWidget {
  final CourseModel course;
  const CourseCard({
    super.key,
    required this.course,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            course.thumbnailUrl,
            width: 90,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          course.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${course.durationSeconds} sec",
        ),
        trailing: const Icon(
          Icons.play_circle_fill,
        ),
        onTap: () {
        },
      ),
    );
  }
}