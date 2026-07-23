import 'package:almentor_mini_player/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class CourseDetailScreen extends StatefulWidget {
  final CourseModel course;
  const CourseDetailScreen({
    super.key,
    required this.course,
  });
  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}
class _CourseDetailScreenState extends State<CourseDetailScreen> {
  VideoPlayerController? videoController;
  ChewieController? chewieController;
  @override
  void initState() {
    super.initState();
    initializeVideo();
  }
  Future<void> initializeVideo() async {
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.course.videoUrl),
    );
    await videoController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: false,
      looping: false,
      aspectRatio: videoController!.value.aspectRatio,
      allowFullScreen: true,
      allowPlaybackSpeedChanging: true,
      showControls: true,
    );
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.course.thumbnailUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.course.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${widget.course.durationSeconds} sec",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(widget.course.description),
            SizedBox(height: 25),
            chewieController != null &&
                chewieController!.videoPlayerController.value.isInitialized
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(
                  controller: chewieController!,
                ),
              ),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 220,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}