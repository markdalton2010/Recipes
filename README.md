### 📱 Summary

This app demonstrates loading a list of recipes from an API using SwiftUI, image loading and caching. Here are some screenshots:

<p float="left">
  <img src="https://github.com/user-attachments/assets/e07b3709-d754-4444-b944-4b0e9e8fefdf" width="220" />
  <img src="https://github.com/user-attachments/assets/778ca21a-d31e-411b-95ab-8f9032c3982c" width="220" />
  <img src="https://github.com/user-attachments/assets/d9649cca-7e3c-4b04-b6c7-f6e7bfdc081e" width="220" />
  <img src="https://github.com/user-attachments/assets/309c30d6-ed91-4624-86aa-f0a6d7ffb9e6" width="220" />
</p>

---

### 🎯 Focus Areas

- **Async image loading** using Swift concurrency (`async/await`)
- **Disk caching** with `FileManager` for persistent image storage
- **Reactive UI** updates with `@Published` and `SwiftUI` binding

I focused on these areas to highlight my ability to handle real-world performance and data flow concerns in SwiftUI apps.

---

### ⏱ Time Spent

Approximately **3–4 hours** total:

- 1 hour – Core image loader and caching logic
- 1.5 hours – UI integration and state management
- 0.5 hour – Unit testing
- 1 hour – Debugging, cleanup, README

---

### ⚖️ Trade-offs and Decisions

- **No third-party libraries**: Used pure Swift to showcase platform knowledge
- **No custom error UI**: Prioritized core loading logic over polish

---

### 🧱 Weakest Part of the Project

- **No cache expiration**: Cached files persist indefinitely
- **Minimal error handling**: Errors are silent in the UI

---

### 💡 Additional Information

- Includes basic unit tests to verify caching and network behavior
- Uses `@MainActor` to ensure UI updates happen on the main thread
