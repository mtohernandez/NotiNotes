# NotiNotes 2.0

A polished, offline-first notes app built with Flutter. Capture text and checklist blocks in a unified editor, personalize each note with curated colors, gradients, and patterns, and schedule local reminders — all stored on-device.

## Features

- **Unified block editor** — type freely or convert any line into a checklist item with one tap from the docked toolbar
- **Per-note style sheet** — 12 curated pastel swatches, 8 gradients, 7 pattern textures, optional custom text color
- **Quick reminders** — chips for "Later today / Tomorrow / Weekend / Next week" plus an inline date & time picker
- **Pinning** — long-press any card to pin it to a separate section at the top
- **Filter chips** — All / Reminders / Checklists / Images
- **Tags** — comma-delimited input with suggested tags from your most used set
- **Container transform open** — cards morph into the editor with a Material container transition
- **Light, dark, and system themes** with Material 3 color schemes
- **Writing fonts** — pick between Inter, Lora, Newsreader, JetBrains Mono, or Source Serif
- **Staggered grid** with masonry layout, fade-in animations, and spring-pressed cards
- **Fully offline** — Hive local storage, no sync, no account, no telemetry

## Tech Stack

- **Flutter 3.41** / Dart 3
- **Material 3** design system
- **Provider** for state management
- **Hive CE** for local storage
- **flutter_local_notifications** for scheduled reminders
- **animations** package for `OpenContainer` transitions
- **flutter_animate** for declarative motion
- **flutter_staggered_grid_view** for masonry layouts
- **board_datetime_picker** for the reminder date/time picker
- **google_fonts** for the writing font picker
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
├── api/                       # Local notifications service
├── helpers/                   # Database, photo picker, gradient alignment
├── models/                    # Note and User data models
├── providers/                 # Notes, Search, UserData state
├── theme/                     # Design tokens, palette, typography, themes
├── screens/                   # Home, editor, settings, user info
└── widgets/
    ├── editor/                # Block widgets, toolbar, app bar
    ├── home/                  # Cards, app bar, filter chips, empty state
    └── sheets/                # Style, reminder, tag, long-press menu sheets
```

## License

This project is for personal use.
