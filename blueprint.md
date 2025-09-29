# Blueprint: Vehicle Fleet Management App

## 1. Project Overview

This is a Flutter-based mobile and web application designed for managing a fleet of vehicles. The application provides two distinct experiences:

1.  **Admin Panel:** A secure, web-oriented interface for staff to perform Create, Read, Update, and Delete (CRUD) operations on vehicle data.
2.  **User-Facing App:** A read-only mobile and web app for end-users to browse, search, and filter the vehicle fleet.

The project is built with a Firebase backend, leveraging Firebase Authentication and Firestore for real-time data storage and synchronization. The architecture is designed to be scalable and maintainable, following modern Flutter development best practices.

## 2. Features & Design Implementation

This section documents the cumulative features and design elements implemented in the application.

### **Core Architecture:**
- **State Management:** `provider` is used for managing app-wide state and dependency injection.
- **Backend:** Google Firebase is the chosen backend.
  - **Authentication:** Firebase Authentication (Email/Password) secures the admin panel.
  - **Database:** Cloud Firestore stores and syncs vehicle data in real-time.
- **Data Model:** A `Vehicle` class (`lib/models/vehicle.dart`) defines the structure for vehicle data, including a `lastUpdated` timestamp.
- **Services:** A `VehicleService` (`lib/services/vehicle_service.dart`) encapsulates all Firestore operations.

### **Admin Panel Features:**
- **Entry Point:** `lib/main_admin.dart`
- **Real-time Dashboard:** Displays a live list of all vehicles.
- **Dynamic Filtering & Searching:** Allows admins to filter by status and search by name, number, or location.
- **CRUD Operations:** Admins can add, edit, and delete vehicles.

### **User-Facing App Features:**
- **Entry Point:** `lib/main_user.dart`
- **Theme:** Styled with a blue Material Design 3 color scheme.
- **Real-time Vehicle List:** The `UserHomeScreen` displays a live, searchable, and filterable list of all vehicles.
- **Search & Filter:** Users can search by vehicle name, number, or location, and filter by status ("All", "Available", "Under Repair", "Unavailable").
- **Read-Only Detail View:** A `VehicleDetailScreen` shows all information for a selected vehicle, including the `lastUpdated` timestamp.

---

## 3. Plan for Current Request: Implement Dark Mode

**Request:** Add a dark mode theme toggle to the user-facing application.

**Vision:** Enhance the user experience by providing a visually comfortable dark theme option. The user should be able to switch between light, dark, and system default themes easily.

**Plan:**

1.  **Update Dependencies:**
    - Ensure the `provider` package is already installed to manage the theme state.

2.  **Create a Theme Provider (`lib/theme_provider.dart`):**
    - Create a new `ThemeProvider` class that uses `ChangeNotifier`.
    - It will hold the current `ThemeMode` (`light`, `dark`, or `system`).
    - It will expose a method, `toggleTheme()`, to switch between light and dark modes.

3.  **Update the User App Entry Point (`lib/main_user.dart`):**
    - Wrap the `UserApp` widget with a `ChangeNotifierProvider` for the new `ThemeProvider`.
    - Update `MaterialApp` to consume the `ThemeProvider`.
    - Define both a `lightTheme` and a `darkTheme` using `ThemeData`.
    - Set the `themeMode` property of the `MaterialApp` to the one provided by `ThemeProvider`.

4.  **Update the User Home Screen (`lib/screens/user_home_screen.dart`):**
    - Add an `IconButton` to the `AppBar`'s `actions`.
    - The icon will change based on the current theme (e.g., `Icons.dark_mode` or `Icons.light_mode`).
    - The `onPressed` callback will call `Provider.of<ThemeProvider>(context, listen: false).toggleTheme()`.

5.  **Test the Implementation:**
    - Run the user app and verify that the theme toggle works as expected.
    - Check that both light and dark themes are applied correctly across all screens.
