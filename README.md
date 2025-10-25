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
git clone https://github.com/maroafenogho/unfold_dash.git
cd unfold_dash

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

## 🎨 Data parsing

For a smooth and effective data parsing that is not UI blocing, I used compute to handle heavy data serialization and comutation in the background, allowing the UI run smoothly as data is fetched.

For the json data processing, the app calls compute from a data transformer class which processes the data and sends it back to the calling method.


**Benefits:**

1. 🧘‍♂️ Prevents UI Freezes

Heavy operations (like parsing large JSON or running data reduction algorithms) can block the main isolate.

compute() offloads this work to a background isolate, keeping your UI smooth and responsive.

Example:
Without compute(), a 5MB JSON parse might cause a noticeable UI lag; with it, the main thread remains free to handle animations, gestures, and rendering.

2. ⚡ Simple and Safe API

It’s a single function call —
```dart
 await compute(fn, message).
 ```

No need to manually manage SendPort/ReceivePort or isolate lifecycle.

Perfect for quick, one-off background tasks.

Example:

```dart
final result = await compute(parseJson, jsonString);
```

This is far simpler than manually spawning and killing isolates.

3. 🌍 Cross-Platform Compatibility

Works on Flutter Web, Android, iOS, macOS, Windows, and Linux.

Even though the Web doesn’t support full Dart isolates, Flutter maps compute() to web workers internally — so you still get concurrency where possible.

4. 🧩 Automatic Isolate Management

compute() automatically:

- Creates a new isolate.

- Runs the function in the background.

- Returns the result back to the main isolate.

- Shuts down the isolate when done.

You don’t have to worry about leaks or cleanup.

5. 🧠 Reduces Boilerplate and Errors

Manually handling isolates is error-prone (ports, serialization, message passing).

compute() abstracts all that away — as long as you use top-level or static functions with serializable arguments/returns.

6. 🔒 Thread-Safe for Pure Functions

Since it enforces pure function usage (no captured variables or references to non-serializable objects), it naturally promotes functional, stateless design — safer and easier to test.

7. 🧮 Improves Perceived Performance

Even though total computation time might not change, users feel the app is faster because the UI remains interactive during background work.

Especially useful in dashboards, charts, or animation-heavy UIs (like your biometrics dashboard).

8. 🧰 Built-In to Flutter SDK

No extra dependencies or third-party packages required.

Well-maintained and optimised by the Flutter team.

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

---

## Use of AI
 
AI tools were strategically integrated throughout the development process to enhance productivity, design quality, and overall code performance. I leveraged AI for ideation, and code optimisation — particularly in designing efficient data handling strategies and implementing the LTTB (Largest-Triangle-Three-Buckets) decimation algorithm. AI also assisted in refining UI/UX patterns, handling performance trade-offs, and documenting best practices. Rather than replacing core engineering effort, AI served as a collaborative assistant — helping accelerate prototyping, improve clarity, and maintain high development standards.

---

## 💡 Summary

This architecture is designed to be:
- **Clean** — with modular separation by feature.  
- **Efficient** — native ChangeNotifier and sealed classes keep it lightweight.  
- **Elegant** — theming and chart sync offer a polished UX.  
- **Scalable** — ready for future growth in data and complexity.

> ⚡ “Built small, designed smart, ready to scale.”
