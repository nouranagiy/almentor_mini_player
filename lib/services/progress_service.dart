import 'package:shared_preferences/shared_preferences.dart';
class ProgressService {
  Future<void> saveProgress(
      String courseId,
      int seconds,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      "progress_$courseId",
      seconds,
    );
  }
  Future<int> loadProgress(
      String courseId,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(
      "progress_$courseId",
    ) ??
        0;
  }
  Future<double> getProgress(
      String courseId,
      int durationSeconds,
      ) async {
    final watched = await loadProgress(courseId);
    if (durationSeconds == 0) return 0;
    return watched / durationSeconds;
  }
}