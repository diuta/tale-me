# Sengkuyung Code Structure Guide

This document explains the current project structure, coding style, and feature responsibilities. Use `PromptPage` as the benchmark for organizing new SwiftUI features.

## Project Structure

```text
sengkuyung/
├── sengkuyung/
│   ├── Features/
│   │   ├── CameraView/
│   │   ├── CountdownPage/
│   │   ├── HistoryDetailView/
│   │   ├── HistoryPage/
│   │   ├── OnboardingPage/
│   │   ├── PromptPage/
│   │   └── SummaryView/
│   ├── Services/
│   ├── Shared/
│   ├── SoundEffects/
│   ├── Assets.xcassets
│   ├── ContentView.swift
│   └── sengkuyungApp.swift
├── sengkuyungTests/
└── sengkuyungUITests/
```

## Feature Folder Pattern

Each feature should live in its own folder under `Features/`. `PromptPage` is the clearest current example.

```text
Features/PromptPage/
├── Components/
│   ├── ActionButtons.swift
│   └── PromptCard.swift
├── PromptModels/
│   ├── SubjectModel.swift
│   └── VerbModel.swift
├── PromptView.swift
└── PromptViewModel.swift
```

Use this pattern when a feature grows beyond a single screen:

| File Type | Responsibility | Example |
| --- | --- | --- |
| `FeatureView.swift` | Main SwiftUI screen and navigation entry point | `PromptView.swift` |
| `FeatureViewModel.swift` | State, screen behavior, and user actions | `PromptViewModel.swift` |
| `Components/` | Small reusable views used by the feature | `PromptCard.swift`, `ActionButtons.swift` |
| `Models/` or `PromptModels/` | Feature-specific sample data or model extensions | `SubjectModel.swift`, `VerbModel.swift` |
| `Shared/` | Data models reused across features | `CompositeModels.swift` |
| `Services/` | App-level utilities for persistence, files, media, or platform APIs | `StorageManager.swift` |

## Coding Style

The codebase uses SwiftUI with a lightweight MVVM structure.

### SwiftUI Views

- Define screens and components as `struct SomeView: View`.
- Keep UI in the `body` property.
- Compose screens from smaller components when the layout has repeated or distinct UI parts.
- Use `#Preview` at the bottom of view files.
- Prefer clear SwiftUI layout primitives: `NavigationStack`, `ZStack`, `VStack`, `HStack`, `TabView`, `ForEach`.
- Use asset catalog image names directly with `Image("assetName")`.
- Use SF Symbols with `Image(systemName:)` for icon buttons.

### State And Data Flow

- Use `@StateObject` when a view owns its view model.
- Use `@ObservedObject` when a child component receives an existing view model.
- Use `@State private var` for local view-only state.
- Use `@AppStorage` for simple persisted app preferences, such as onboarding completion.
- Use `@Published` properties inside `ObservableObject` view models.

Example from `PromptPage`:

```swift
struct PromptView: View {
    @StateObject var viewModel = PromptViewModel()
}

struct ActionButtons: View {
    @ObservedObject var viewModel: PromptViewModel
}
```

### Models

- Use `struct` models for simple value data.
- Conform shared prompt models to `Identifiable` and `Codable`.
- Keep reusable model definitions in `Shared/`.
- Keep feature-specific sample data in extensions near the feature.
- Use SwiftData `@Model` for persisted app data.

Current shared models:

| Model | Purpose |
| --- | --- |
| `SubjectPrompt` | A selectable story subject with `id`, `name`, and image asset |
| `VerbPrompt` | A selectable action with `id`, `name`, image asset, and background asset |
| `HistoryData` | SwiftData model for saved story history and optional video/thumbnail names |

### Naming

- Types use PascalCase: `PromptView`, `PromptViewModel`, `SubjectPrompt`.
- Properties and methods use camelCase: `selectedSubject`, `shuffleBoth()`.
- Feature folders are named after the feature or screen.
- Component names should describe the UI role: `PromptCard`, `ActionButtons`.

### Formatting

- Use 4-space indentation.
- Put imports at the top.
- Keep one main type per file when practical.
- Separate logical sections with blank lines.
- Avoid force unwrapping.
- Keep comments for non-obvious logic only.

## PromptPage Benchmark

`PromptPage` should be used as the benchmark because it demonstrates the desired separation of responsibilities:

- `PromptView` owns the screen layout and creates `PromptViewModel`.
- `PromptViewModel` owns prompt selection state and shuffle behavior.
- `PromptCard` renders a reusable tappable card.
- `ActionButtons` renders the bottom controls and receives the existing view model.
- `SubjectModel` and `VerbModel` provide sample prompt data through model extensions.
- `SubjectPrompt` and `VerbPrompt` stay in `Shared/CompositeModels.swift` because other features can use them.

When creating a new feature, start with:

```text
Features/NewFeature/
├── Components/
├── NewFeatureView.swift
├── NewFeatureViewModel.swift
└── NewFeatureModel.swift
```

Only add folders that the feature actually needs. If a screen is still a placeholder, a single `View` file is enough.

## Feature Overview

| Feature | Current Responsibility | Main Files |
| --- | --- | --- |
| OnboardingPage | Shows onboarding pages, page indicators, and stores completion with `@AppStorage` | `OnboardingView.swift`, `OnboardingModel.swift` |
| PromptPage | Lets users pick a story verb and subject, shuffle prompts, and start the flow | `PromptView.swift`, `PromptViewModel.swift`, `PromptCard.swift`, `ActionButtons.swift` |
| CountdownPage | Displays the pre-recording countdown scene with chat and dialog components | `CountdownView.swift`, `ChatBubble.swift`, `DialogBox.swift` |
| CameraView | Placeholder for future camera or recording experience | `CameraView.swift`, `CameraViewModel.swift`, `CameraModel.swift` |
| HistoryPage | Defines persisted `HistoryData`; view and view model are currently minimal placeholders | `HistoryModel.swift`, `HistoryView.swift`, `HistoryViewModel.swift` |
| HistoryDetailView | Placeholder for detailed saved story/history playback | `HistoryDetailView.swift`, `HistoryDetailViewModel.swift`, `HistoryDetailModel.swift` |
| SummaryView | Placeholder for story/session summary | `SummaryView.swift`, `SummaryViewModel.swift`, `SummaryModel.swift` |

## App Flow

- `sengkuyungApp` is the app entry point.
- The app starts at `LandingView`.
- `LandingView` checks `hasCompletedOnboarding`.
- New users see `OnboardingView`.
- Returning users go to `PromptView`.
- `PromptView` navigates to `CountdownView` when the user taps Start.

## Persistence And Media

- SwiftData is configured in `sengkuyungApp` with `HistoryData`.
- `StorageManager` handles document directory access.
- `StorageManager` saves history records into SwiftData.
- For videos, `StorageManager` moves the temporary video file into Documents and generates a JPEG thumbnail with AVFoundation/UIKit.

## Assets

- Visual assets live in `Assets.xcassets`.
- Prompt subjects and verbs reference assets by string name.
- Sound effects live in `SoundEffects/`.

When adding new prompt data, make sure the asset names in `SubjectModel.swift` or `VerbModel.swift` match files in `Assets.xcassets`.
