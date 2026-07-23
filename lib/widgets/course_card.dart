import 'package:almentor_mini_player/models/course_model.dart';
import 'package:flutter/material.dart';
class CourseCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onTap;
  final double progress;
  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.progress,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: ListTile(
        onTap: onTap,
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${course.durationSeconds} sec"),
            SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
            SizedBox(height: 4),
            Text(
              "${(progress * 100).toStringAsFixed(0)}% watched",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.play_circle_fill,
        ),
      ),
    );
  }
}