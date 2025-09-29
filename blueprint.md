# Blueprint: Vehicle Fleet Management App

## 1. Project Overview

This is a Flutter-based mobile and web application designed for managing a fleet of vehicles. The application provides an administrative interface to perform Create, Read, Update, and Delete (CRUD) operations on vehicle data.

The project is built with a Firebase backend, leveraging Firebase Authentication for user login and Firestore as a real-time, NoSQL database for data storage. The architecture is designed to be scalable and maintainable, following modern Flutter development best practices.

## 2. Features & Design Implementation

This section documents the cumulative features and design elements implemented in the application.

### **Core Architecture:**
- **State Management:** `provider` is used for managing app-wide state and dependency injection, specifically for making the `VehicleService` available to the UI.
- **Backend:** Google Firebase is the chosen backend.
  - **Authentication:** Firebase Authentication (Email/Password) is used to secure the admin panel.
  - **Database:** Cloud Firestore is used to store and sync the vehicle data in real-time.
- **Data Model:** A `Vehicle` class (`lib/models/vehicle.dart`) defines the structure for vehicle data, including fields like `id`, `name`, `vehicleNumber`, `status`, `location`, and `details`.
- **Services:** A dedicated `VehicleService` (`lib/services/vehicle_service.dart`) encapsulates all Firestore database operations, abstracting the data layer from the UI.

### **User Interface (UI) & User Experience (UX):**
- **Framework:** Built with Flutter using Material Design 3 (`useMaterial3: true`).
- **Primary Color Scheme:** Based on a seed color of `Colors.indigo`.
- **Admin Dashboard (`lib/screens/dashboard_screen.dart`):**
  - **Real-time Vehicle List:** Displays a live-updating list of all vehicles from Firestore.
  - **Dynamic Filtering & Searching:**
    - A responsive `FilterBar` allows admins to filter the vehicle list by status (`All`, `Available`, `Under Repair`, `Unavailable`).
    - A search field allows for finding vehicles by `name`, `vehicleNumber`, or `location`.
  - **Polished Vehicle Cards:** Each vehicle is displayed in a `Card` with a clean layout:
    - **Status Indicator:** A colored icon on the left indicates the vehicle's status (Green for Available, Orange for Repair, Red for Unavailable).
    - **Details:** Displays the vehicle's name, number, location, and any additional details.
    - **Actions Menu:** A popup menu (`...`) provides options to **Edit** or **Delete** the vehicle.
- **Add/Edit Screen (`lib/screens/add_edit_vehicle_screen.dart`):**
  - A single, reusable form for both creating new vehicles and updating existing ones.
  - Includes input validation to ensure required fields are not empty.
- **Navigation:** Standard `MaterialPageRoute` navigation is used to move between the dashboard and the add/edit screen.

### **Security:**
- **Firestore Rules:** The database is secured with rules that only allow authenticated users (`request.auth != null`) to read or write to the `vehicles` collection. This prevents unauthorized access to the data.

## 3. Plan for Current Request

**Request:** "now i want to download this project"

**Plan:**
1.  **Finalize Documentation:** Create this `blueprint.md` file to document the project's current state as per development guidelines.
2.  **Prepare for Transfer:** Initialize a local Git repository and commit all project files.
3.  **Provide Instructions:** Guide the user on how to push this repository to a remote service (like GitHub) and then clone it to their local machine.
