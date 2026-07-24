import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almentor_mini_player/services/progress_service.dart';
void main() {
  late ProgressService progressService;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    progressService = ProgressService();
  });
  test(
    'saveProgress should save and load progress correctly',
        () async {
      await progressService.saveProgress(
        'c001',
        15,
      );
      final result =
      await progressService.loadProgress('c001');
      expect(result, 15);
    },
  );
}