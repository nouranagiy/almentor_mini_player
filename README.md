# Almentor Mini Course Player

This project was developed as part of the Flutter Mobile Intern Technical Assessment.

The app allows users to browse available courses, watch course videos, and continue watching from where they stopped. It also displays the user's watching progress for each course.

## Features

* Display a list of available courses.
* Show course details.
* Play videos using Chewie.
* Resume video playback from the last saved position.
* Display watching progress for each course.
* Save progress locally using SharedPreferences.
* Handle video loading errors by showing an error message and allowing the user to retry.

## Packages Used

* provider
* video_player
* chewie
* shared_preferences

## Project Structure

```text
lib/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
└── main.dart
```

## Getting Started

1. Clone the repository.

```bash
git clone <repository_url>
```

2. Open the project.

```bash
cd almentor_mini_player
```

3. Install the dependencies.

```bash
flutter pub get
```

4. Run the application.

```bash
flutter run
```

## Running Tests

To run all tests:

```bash
flutter test
```

## Notes

* Course data is loaded from a local mock JSON.
* Watching progress is stored locally using SharedPreferences.
* If the video fails to load, the app shows an error message with a Retry button.

