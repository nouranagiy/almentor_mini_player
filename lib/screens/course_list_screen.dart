import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Courses"),
        ),
        body: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
        // جيبي الكورس الحالي
        return CourseCard(
        course: courses[index],
    );
  },
    ),
    );
  }
}