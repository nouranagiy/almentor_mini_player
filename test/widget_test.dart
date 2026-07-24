import 'package:almentor_mini_player/providers/course_provider.dart';
import 'package:almentor_mini_player/screens/course_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
void main() {
  testWidgets(
    'Course list screen loads',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CourseProvider(),
          child: const MaterialApp(
            home: CourseListScreen(),
          ),
        ),
      );
      expect(find.text("Courses"), findsOneWidget);
    },
  );
}