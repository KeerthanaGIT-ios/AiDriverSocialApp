# SocialApp

An Instagram-inspired iOS social media app built with **SwiftUI** and **MVVM** architecture. Fully functional UI with mock data — no backend required to run.

## Features

| Feature | Description |
|---------|-------------|
| **Home Feed** | Instagram-style feed with stories bar, post cards, double-tap to like, bookmark |
| **Explore** | Mixed grid layout (1x1 + 2x2 tiles) with search bar and user discovery |
| **Create Post** | Image picker (PhotosPicker) with preview and caption input |
| **Chat** | Conversation list and message detail with bubbles and input bar |
| **User Profile** | Profile header, stats (posts/followers/following), follow button, post grid |
| **User Search** | Live debounced search with recent searches history |

## Screenshots

> Run the app on simulator to preview all screens.

## Architecture

```
MVVM + Repository Pattern
```

```
SocialApp/
├── Models/              # Data models (User, Post, Message, Conversation, Story)
├── Views/
│   ├── Feed/            # Home feed, PostCardView, StoriesBar
│   ├── Explore/         # Explore grid with mixed layout patterns
│   ├── Create/          # Create post flow with image picker
│   ├── Chat/            # Chat list, detail, message bubbles
│   ├── Profile/         # User profile, stats, post grid
│   ├── Search/          # User search with recent searches
│   └── Components/      # Reusable: AvatarView, StoryItemView, ActionBars
├── ViewModels/          # One ViewModel per feature
├── Services/            # Protocol-based services (mock + Firebase-ready)
└── Repositories/        # Repository layer abstracting data sources
```

## Data Flow

```
View → ViewModel → Repository → Service (Mock / Firebase)
```

- **Views** only handle presentation — no business logic
- **ViewModels** manage state and coordinate data
- **Repositories** abstract data sources from ViewModels
- **Services** handle direct API/Firebase calls (currently mock)

## Tech Stack

- **SwiftUI** (iOS 17+)
- **Swift Concurrency** (async/await)
- **Combine** (debounced search)
- **PhotosUI** (image picker)
- **Firebase** (SDK integrated, mock data by default)

## Requirements

- Xcode 15+
- iOS 17.0+
- macOS Sonoma+

## Getting Started

```bash
# Clone
git clone https://github.com/KeerthanaGIT-ios/AiDriverSocialApp.git

# Open in Xcode
open SocialApp.xcodeproj

# Run on simulator (Cmd + R)
```

No `GoogleService-Info.plist` needed — the app runs with mock data by default.

### Enable Firebase (Optional)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Download `GoogleService-Info.plist` and add to the `SocialApp` target
3. The app will automatically switch from mock to Firebase services

## Key Components

| Component | File | Purpose |
|-----------|------|---------|
| `PostCardView` | `Views/Feed/PostCardView.swift` | Instagram-style post card with actions |
| `StoriesBarView` | `Views/Feed/StoriesBarView.swift` | Horizontal stories with gradient rings |
| `ExploreGridPattern` | `Views/Explore/ExploreGridPattern.swift` | Mixed 1x1/2x2 grid layout engine |
| `MessageBubble` | `Views/Chat/MessageBubble.swift` | Chat bubble (blue sender, gray receiver) |
| `AvatarView` | `Views/Components/AvatarView.swift` | Reusable circular avatar with fallback |
| `HeartAnimationOverlay` | `Views/Components/HeartAnimationOverlay.swift` | Double-tap like animation |

## AI-Assisted Development

This project was built using an **AI agent orchestration system** with specialized agents:

| Agent | Role |
|-------|------|
| `project-orchestrator` | Manages workflow and delegates tasks |
| `planner-agent` | Feature breakdown and task planning |
| `ui-agent` | SwiftUI screens and components |
| `data-agent` | Models, services, and Firebase integration |
| `git-agent` | Version control, commits, and PRs |

Agent definitions are in `.claude/agents/`.

## License

This project is for educational and demonstration purposes.
