# ⚖️ Trade-offs & Design Decisions

This document outlines the key trade-offs made during the development of the **Biometrics Dashboard**, explaining the reasoning behind each major technical and design choice. The goal was to maintain a clean architecture, responsive performance, and developer-friendly maintainability — while staying lightweight and scalable.

---

## 🧱 Architecture

### ✅ Decision:
Adopted a **Feature-First + Layered Architecture** structure:
```
features/
  dashboard/
    application/
    data/
    domain/
    presentation/
shared/
```

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **Feature-first** (chosen) | Improves modularity and scalability; easy to isolate dashboard logic | Slightly more boilerplate for small projects |
| **Layer-first** | Simpler for small apps | Harder to scale when adding more features |

### 💡 Why this was best:
Feature-first architecture naturally supports growth. Each feature encapsulates its data, logic, and UI — keeping concerns isolated and testing straightforward.

---

## 🧠 State Management

### ✅ Decision:
Used **Flutter's native `ChangeNotifier`** for managing state.

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **ChangeNotifier (chosen)** | Built-in, simple, minimal boilerplate, easy to scale moderately | Lacks advanced features like computed states |
| **Riverpod / Bloc** | More scalable and testable for complex apps | Adds learning curve and boilerplate for this small project |

### 💡 Why this was best:
Given the small-to-medium scale of the app, `ChangeNotifier` provided enough control without introducing unnecessary complexity. It strikes a balance between simplicity and maintainability.

---

## 🧩 UI State Management (Sealed Classes vs Enums)

### ✅ Decision:
Used **Sealed Classes** for `DashboardUIState`.

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **Sealed Classes (chosen)** | Strong type-safety, more expressive, reduces boilerplate | Slightly newer Dart feature; less familiar to some |
| **Enums** | Simple to use and familiar | Requires extra conditionals or mapping logic; less flexible |

### 💡 Why this was best:
Sealed classes allow modeling each state (`Loading`, `Loaded`, `Error`, `Empty`) as distinct objects, enabling cleaner and more readable UI logic — with less code repetition.

---

## 🎨 Theming & Extensions

### ✅ Decision:
Used a **custom `ThemeExtension`** (`AppThemeData`) to manage colour schemes and typography.

```dart
class AppThemeData extends ThemeExtension<AppThemeData> {
  final AppColorScheme colorScheme;
  final AppTypography typography;
}
```

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **ThemeExtension (chosen)** | Centralised control, dark/light adaptability, reusable, clean overrides | Requires initial setup effort |
| **Direct ThemeData edits** | Quicker for small projects | Leads to cluttered and repetitive styling code |

### 💡 Why this was best:
Theme extensions make the app scalable and future-proof — all design elements stay consistent across dark and light modes with fine-grained control.

---

## 📊 Time-Series Charts & Visualisation

### ✅ Decision:
Implemented three synchronised charts — HRV, RHR, and Steps — using **FlChart** with:
- Shared tooltips & crosshair
- 7d/30d/90d range switching
- Journal entry annotations
- 7-day rolling mean ±1σ bands
- Pan/Zoom interactions

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **FlChart (chosen)** | Lightweight, interactive, customisable | Not as feature-rich as professional chart libraries |
| **Syncfusion / ECharts** | Enterprise-level features | Heavier dependencies, less Flutter-native control |

### 💡 Why this was best:
FlChart provides just enough flexibility and performance for smooth rendering without bloating the app size — perfect for an interactive dashboard demo.

---

## 🚀 Performance & Decimation

### ✅ Decision:
Applied **Largest-Triangle-Three-Buckets (LTTB)** algorithm for data decimation on large datasets.

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **LTTB (chosen)** | Preserves shape, min, and max; visually accurate | Slightly complex implementation |
| **Simple averaging** | Easier to compute | Loses visual accuracy; hides outliers |

### 💡 Why this was best:
LTTB offers a strong balance between performance and fidelity — keeping the visual trends accurate while ensuring <16ms frame rendering even on 10k+ points.

---

## 🌐 Data Handling & Robustness

### ✅ Decision:
Mocked data from `/assets/` with simulated latency (700–1200 ms) and random 10% failures.

### ⚖️ Trade-off:
| Approach | Pros | Cons |
|-----------|------|------|
| **Simulated real-world delays (chosen)** | Tests resilience under failure, improves UX states | Slightly slower dev iterations |
| **Instant load mocks** | Faster to test | Doesn’t simulate real-world network issues |

### 💡 Why this was best:
Adding latency and failure simulation ensures error handling, loading states, and retry logic are robust — mimicking real production scenarios.

---

## 💅 UX & Responsiveness

### ✅ Decision:
Added responsive layouts, dark mode, and clear empty/error states.

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **Responsive design (chosen)** | Works across mobile and desktop | Requires more layout tuning |
| **Fixed width** | Easier to implement | Poor usability on smaller screens |

### 💡 Why this was best:
Since this is a **Flutter Web demo**, flexibility across resolutions (min 375px) ensures visual integrity on all devices.

---

## 🧪 Testing Approach

- **Unit Tests** — validate decimator preserves min/max and correct output size.
- **Widget Tests** — verify range-switching syncs all charts and tooltips remain consistent.

### ⚖️ Trade-off:
| Option | Pros | Cons |
|--------|------|------|
| **Targeted tests (chosen)** | Covers critical visual and data logic | Doesn’t test every widget exhaustively |
| **Full coverage** | Extremely reliable | Overkill for a lightweight demo app |

---

## 🏁 Summary

| Area | Decision | Rationale |
|------|-----------|------------|
| Architecture | Feature-first modular | Scalable, clean separation |
| State Mgmt | `ChangeNotifier` | Lightweight & scalable enough |
| UI States | Sealed Classes | Less boilerplate, more clarity |
| Theming | Theme Extensions | Centralised, flexible control |
| Charts | FlChart | Lightweight & interactive |
| Decimation | LTTB | Visual fidelity + performance |
| UX | Responsive + graceful states | Smooth real-world behaviour |

---

### 🧩 Final Thought
Every trade-off was made with **intentional balance** between clarity, performance, and maintainability.  
This dashboard isn’t just functional — it’s **a teaching piece in thoughtful Flutter engineering**.
