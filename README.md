# 🧭 Project Overview

This Flutter project is structured around a **feature-first architecture** designed for clarity, scalability, and smooth performance.  
It’s built to visualise biometrics data interactively while demonstrating thoughtful design, efficient state handling, and performance optimisation.

---

## 📂 Folder Structure

```
lib/
│
├── app/
│   └── app.dart                   # Root widget and app-level setup
│
├── src/
│   ├── features/
│   │   └── dashboard/
│   │       ├── application/       # State management logic
│   │       │   ├── dashboard_notifier.dart
│   │       │   └── dashboard_ui_state.dart
│   │       │
│   │       ├── data/              # Data sources and repositories
│   │       │   ├── dashboard_repo_impl.dart
│   │       │   └── dashboard_repository.dart
│   │       │
│   │       ├── domain/            # Core business logic and DTOs
│   │       │   └── dtos/response/
│   │       │       ├── biometrics_point.dart
│   │       │       └── journal_dto.dart
│   │       │
│   │       └── presentation/      # UI layer (screens & widgets)
│   │           ├── screens/
│   │           │   └── dashboard.dart
│   │           └── widgets/
│   │               ├── chart.dart
│   │               ├── loading_skeleton.dart
│   │               ├── theme_switcher.dart
│   │               └── widgets.dart
│   │
│   └── shared/                    # Reusable components and utilities
│       ├── enums/
│       ├── exceptions/
│       ├── services/
│       ├── theme/
│       ├── utility/
│       ├── view_model/
│       ├── widgets/
│       ├── constants.dart
│       ├── extensions.dart
│       ├── shared.dart
│       └── typedefs.dart
│
└── main.dart                      # Entry point
```

---

## ⚙️ Setup Instructions

### Prerequisites
- **Flutter SDK:** `3.35.1` or later  
- **Dart:** `>=3.0.0`
- **IDE:** VSCode or Android Studio recommended

### Steps to Run
```bash
# 1. Clone the repository
git clone https://github.com/yourusername/yourproject.git
cd yourproject

# 2. Get dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## 🧩 Architecture Summary

The project follows a **Clean Feature-Based Architecture**, with clear separation of concerns across four main layers:

| Layer | Responsibility |
|-------|----------------|
| **Domain** | Pure data models and DTOs — framework-independent. |
| **Data** | Repository and data retrieval (mock or live). |
| **Application** | State management and UI coordination. |
| **Presentation** | UI widgets, screens, and theming. |
| **Shared** | Common utilities, theme, and extensions used across features. |

This architecture enables **clear ownership**, easy testing, and smooth scalability.

---

## 🧠 State Management – Native `ChangeNotifier`

This project uses **Flutter’s native `ChangeNotifier`** for state management — a choice driven by simplicity and sufficiency.

**Why `ChangeNotifier`?**
- **Lightweight and built-in** — no external dependencies.
- **Reactive and efficient** — `notifyListeners()` propagates UI updates instantly.
- **Easy to reason about** — state transitions are explicit and predictable.
- **Scales reasonably** for projects of this scope, and can later evolve into something more sophisticated (like `Notifier` or `Riverpod`) without major refactors.

> “ChangeNotifier is small, fast, and perfectly suited for apps that value simplicity over ceremony.”

---

## 🧾 UI State – Sealed Classes, Not Enums

For representing UI state, sealed classes were chosen over enums.

```dart
sealed class DashboardUIState {}

class DashboardLoading extends DashboardUIState {}
class DashboardLoaded extends DashboardUIState {}
class DashboardError extends DashboardUIState {}
```

**Why?**
- Each state can **hold its own data**.
- **Type-safe pattern matching** with less boilerplate.
- Easier to **extend or modify** as the app grows.

> “Enums describe — sealed classes *express*.”

---

## 🎨 Theming with Theme Extensions

This project implements a **custom `AppThemeData`** class built on top of Flutter’s `ThemeExtension` system, combining a **colour scheme** and **typography system** for a complete, composable theme layer.

```dart
class AppThemeData extends ThemeExtension<AppThemeData> {
  final AppColorScheme colorScheme;
  final AppTypography typography;

  AppThemeData({
    required this.colorScheme,
    required this.typography,
  });

  @override
  AppThemeData copyWith({
    AppColorScheme? colorScheme,
    AppTypography? typography,
  }) => AppThemeData(
        colorScheme: colorScheme ?? this.colorScheme,
        typography: typography ?? this.typography,
      );

  @override
  AppThemeData lerp(ThemeExtension<AppThemeData>? other, double t) {
    if (other is! AppThemeData) return this;
    return AppThemeData(
      colorScheme: AppColorScheme.lerp(colorScheme, other.colorScheme, t),
      typography: AppTypography.lerp(typography, other.typography, t),
    );
  }
}
```

**Advantages**
- Gives **complete control** over colour, typography, and spacing.
- Makes it easy to switch or adjust themes (e.g. light/dark or brand-specific).
- Keeps UI code **semantic and readable** — e.g. `theme.colorScheme.success`.
- Scales naturally with new properties (shadows, animations, etc.).

> “Theme extensions turn design tokens into living code.”

---

## 📉 Data Decimation – LTTB (Largest Triangle Three Buckets)

To maintain smooth chart performance across large datasets, this project implements the **LTTB** algorithm for data decimation.

**Why LTTB?**
- Retains key visual patterns while dropping redundant points.
- Keeps frame times consistently below 16ms per frame.
- Provides a **natural visual downsampling** without distorting trends.
- Perfect for biometrics or time-series visualisations.

> “LTTB doesn’t throw data away — it curates it.”

---

## 📊 Data Visualisation & Features

The dashboard visualises **three biometric metrics** over time:

- **HRV (Heart Rate Variability)**
- **RHR (Resting Heart Rate)**
- **Steps**

**Core Interactions:**
- Shared tooltip and crosshair across all charts.
- Range controls (7d / 30d / 90d).
- Smooth pan and zoom.
- Vertical annotations for journal entries (tap to view mood/note).
- HRV band with 7-day rolling mean ±1σ (standard deviation).

---

## 🧰 Tech Stack

| Category | Libraries |
|-----------|------------|
| **Framework** | Flutter 3.35.1 |
| **State Management** | Native `ChangeNotifier` |
| **Charting** | `fl_chart` |
| **Data Decimation** | Custom LTTB implementation |
| **Testing** | `flutter_test`, `mocktail` |
| **Theming** | `ThemeExtension` with `AppThemeData`, `AppColorScheme`, `AppTypography` |
| **Utilities** | `intl`, `collection` |

---

## ⚡ Performance Notes

- LTTB reduces 10K+ points to <500 key points with no visible trend loss.
- Maintains <16ms frame time for 90-day datasets.
- Mock latency (700–1200ms) and ~10% simulated failures ensure realistic behaviour.
- Handles **loading**, **error**, and **empty** states gracefully.
- Fully responsive layout with dark mode support.

---

## ✨ Summary

This biometrics dashboard demonstrates how **clean architecture, minimal dependencies, and Flutter’s built-in tools** can deliver an elegant and high-performance data experience.  

From **sealed states** to **LTTB decimation** and **custom theming**, every design decision was made to keep the app lightweight, expressive, and scalable.

> 🧩 “Simple. Elegant. Intentional. Built to perform — and to last.”
