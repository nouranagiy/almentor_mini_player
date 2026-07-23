import 'package:almentor_mini_player/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:almentor_mini_player/services/progress_service.dart';
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
  final ProgressService progressService = ProgressService();
  int lastSavedSecond = -1;
  bool hasError = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    initializeVideo();
  }
  Future<void> initializeVideo() async {
    try {
      isLoading = true;
      hasError = false;
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.course.videoUrl),
      );
      await videoController!.initialize();
      final savedSeconds =
      await progressService.loadProgress(widget.course.id);
      if (savedSeconds > 0) {
        await videoController!.seekTo(
          Duration(seconds: savedSeconds),
        );
      }
      chewieController = ChewieController(
        videoPlayerController: videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
      );
      videoController!.addListener(() async {
        if (!videoController!.value.isInitialized) return;
        final currentSecond =
            videoController!.value.position.inSeconds;
        if (currentSecond != lastSavedSecond) {
          lastSavedSecond = currentSecond;
          await progressService.saveProgress(
            widget.course.id,
            currentSecond,
          );
        }
      });
      isLoading = false;
    } catch (e) {
      hasError = true;
      isLoading = false;
    }
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void dispose() {
    if (videoController != null && videoController!.value.isInitialized) {
      final position = videoController!.value.position;
      final duration = videoController!.value.duration;
      if (position >= duration) {
        progressService.saveProgress(widget.course.id, 0);
      } else {
        progressService.saveProgress(widget.course.id, position.inSeconds);
      }
    }
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
            if (isLoading)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            else if (hasError)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Failed to load video",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          initializeVideo();
                        },
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(
                    controller: chewieController!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}