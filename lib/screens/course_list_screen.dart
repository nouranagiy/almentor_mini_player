import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'package:almentor_mini_player/screens/course_details_screen.dart';
class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});
  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}
class _CourseListScreenState extends State<CourseListScreen> {
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final courses = provider.courses;
    final progress = provider.progress;
    return Scaffold(
        appBar: AppBar(
          title: Text("Courses"),
        ),
        body: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCard(
                course: course,
                progress: progress[course.id] ?? 0,
                onTap: () async {
                 await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseDetailScreen(course: course),
                    ),
                  );
                 await context.read<CourseProvider>().loadCourses();                },
              );
              },
    ),
    );
  }
}