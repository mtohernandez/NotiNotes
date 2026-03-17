# NotiNotes

A customizable notes app built with Flutter. Create, organize, and personalize your notes with colors, gradients, patterns, tags, todo lists, images, and scheduled reminders.

![NotiNotes Preview](https://user-images.githubusercontent.com/67434849/207646618-66858072-55c9-4a12-a08a-22bf1db91f04.png)

## Features

- **Rich note creation** — title, content, images, and todo lists
- **Color themes** — pick any color, gradient, or pattern for each note
- **Tags** — organize notes with custom tags and filter by them
- **Search** — find notes by title or tag
- **Reminders** — schedule local notifications for any note
- **Masonry layout** — notes displayed in a staggered grid
- **Dark UI** — fully dark-themed interface

## Tech Stack

- **Flutter 3.41** / Dart 3
- **Provider** for state management
- **Hive CE** for local storage
- **flutter_local_notifications** for scheduled reminders
- Android SDK 36 / iOS 13.0+

## Getting Started

### Prerequisites

- Flutter SDK 3.41+
- JDK 17
- Android SDK 36 (for Android builds)
- Xcode 15+ (for iOS builds)

### Setup

```bash
git clone https://github.com/mtohernandez/NotiNotes.git
cd NotiNotes
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── api/                  # Notifications API
├── helpers/              # Color picker, database, display, photo utilities
├── models/               # Note and User data models
├── providers/            # Notes, Search, and UserData state management
├── screens/              # Home, NoteView, UserInfo, Information screens
└── widgets/
    ├── items/            # Reusable UI components (note cards, tags, todos, appbars)
    ├── navigation/       # Bottom navigation bar
    └── note_creation/    # Note editor widgets (color picker, tags, reminders, media)
```

## License

This project is for personal use.
