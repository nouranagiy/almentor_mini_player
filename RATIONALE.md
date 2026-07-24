# Design Decisions

## Why I chose Provider

I decided to use Provider because it is simple, easy to understand, and fits the size of this project. It helped me separate the UI from the business logic and made the code more organized.

## Resume Playback

To remember where the user stopped watching, I used SharedPreferences. Every few seconds while the video is playing, the current position is saved. When the user opens the same course again, the app loads the saved position and resumes the video from there.

For the progress shown in the course list, I used the `durationSeconds` value provided in the mock data. If this were a real production app, I would calculate the progress based on the actual duration of the video instead.

## If I had more time

If I had more time, I would improve the app by adding features such as downloading videos for offline viewing, caching images, adding search and filtering, improving animations, and syncing user progress with a backend service.
