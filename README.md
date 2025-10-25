# 🧭 Project Overview

This Flutter project is structured for **clarity, scalability, and strong separation of concerns**. It leverages a **feature-first architecture** with clean layers, ensuring maintainability and clear data flow between presentation, application, domain, and data layers.

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

## 🧠 State Management

This project uses Flutter’s **native ChangeNotifier** for state management.

> “Small enough to be simple, yet capable enough to scale.”

The `ChangeNotifier` pattern was chosen because:
- It avoids external dependencies.
- It offers **clean reactive patterns** with minimal boilerplate.
- It’s **easy to extend** for larger projects later on.

---

## 🧾 UI State – Sealed Classes

Rather than using enums, **sealed classes** define UI states in `dashboard_ui_state.dart`:

```dart
sealed class DashboardUIState {}

class DashboardLoading extends DashboardUIState {}
class DashboardLoaded extends DashboardUIState {}
class DashboardError extends DashboardUIState {}
```

**Why this approach?**
- **Type-safe** and **expressive**.
- Each state can hold specific data.
- Eliminates cumbersome switch statements.

---

## 🎨 Theming

The app uses a **custom ThemeExtension** pattern via the `AppThemeData` class:

```dart
class AppThemeData extends ThemeExtension<AppThemeData> {
  final AppColorScheme colorScheme;
  final AppTypography typography;
}
```

**Benefits:**
- Fine-grained colour and typography control.
- Smooth light/dark mode transitions.
- Easily extensible for brand evolution.

---

## 📈 Time-Series Visualisation

The **dashboard’s highlight** is its **interactive time-series charts**, displaying metrics like HRV, RHR, and Steps.

### 🔹 Chart Synchronisation
All three charts are **time-synced**, meaning hover or tap interactions reflect on all simultaneously — ensuring coherent visual storytelling.

### 🔹 Range Controls
Dynamic range toggling between **7, 30, and 90 days**, updating:
- Visible domain (X-axis)
- Data resolution (via decimation)
- Tooltip visibility and markers

### 🔹 Rolling Mean Bands (HRV)
The HRV chart includes **7-day rolling mean ± 1σ bands** to visualise variability and recovery trends.

### 🔹 Journal Markers
Journal entries appear as **vertical annotations**. Tapping shows **mood and context**, blending subjective and biometric data.

### 🔹 LTTB Decimation
The **Largest Triangle Three Buckets (LTTB)** algorithm is used to reduce large datasets efficiently, maintaining trend integrity and ensuring smooth rendering.

> “It’s not just a chart — it’s your data’s story, simplified.”

---

## 💡 Summary

This architecture is designed to be:
- **Clean** — with modular separation by feature.  
- **Efficient** — native ChangeNotifier and sealed classes keep it lightweight.  
- **Elegant** — theming and chart sync offer a polished UX.  
- **Scalable** — ready for future growth in data and complexity.

> ⚡ “Built small, designed smart, ready to scale.”
