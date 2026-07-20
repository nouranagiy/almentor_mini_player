class CourseModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final int durationSeconds;
  final String description;
  final String videoUrl;
  CourseModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.description,
    required this.videoUrl,
  });
}