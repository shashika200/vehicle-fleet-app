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
- **Data Model:** A `Vehicle` class (`lib/models/vehicle.dart`) defines the structure for vehicle data.
- **Services:** A `VehicleService` (`lib/services/vehicle_service.dart`) encapsulates all Firestore operations.

### **Admin Panel Features:**
- **Entry Point:** `lib/main_admin.dart`
- **Real-time Dashboard:** Displays a live list of all vehicles.
- **Dynamic Filtering & Searching:** Allows admins to filter by status and search by name, number, or location.
- **CRUD Operations:** Admins can add, edit, and delete vehicles. The "type" field has been removed from the creation UI.
- **Security:** Firestore rules restrict write access to authenticated admin users.

---

## 3. Plan for Current Request: User-Facing App Overhaul

**Request:** "change the user app, Purpose: Allows users to view vehicle details (read-only) with search and filter options."

**Vision:** Create a functional and easy-to-use application for users to find vehicle information quickly. The UI will be clean, following Material Design principles with a blue color scheme.

**Plan:**

1.  **Update Data Model (`lib/models/vehicle.dart`):**
    - Add a `lastUpdated` timestamp field to the `Vehicle` model to track when a record was last modified.

2.  **Update Data Service (`lib/services/vehicle_service.dart`):**
    - Modify the `addVehicle` and `updateVehicle` methods to automatically set the `lastUpdated` timestamp on every write operation.

3.  **Create the User App Entry Point (`lib/main_user.dart`):**
    - Initialize the user-facing app.
    - Configure a `MaterialApp` with a blue theme and set the title to "Vehicle Management".
    - Set `UserHomeScreen` as the home widget.

4.  **Develop the User Home Screen (`lib/screens/user_home_screen.dart`):**
    - This screen will serve as the main interface for the user.
    - **UI Structure:**
        - `AppBar` with the title "Vehicle Management".
        - A search `TextField` at the top to filter vehicles by name, number, or location.
        - A set of filter chips/buttons below the search bar for status: "All", "Available", "Under Repair", "Unavailable".
        - A scrollable list of `Vehicle` cards displaying the search and filter results.
    - **Functionality:**
        - Implement state management to handle search queries and filter selections.
        - Fetch vehicle data using the `VehicleService`.
        - Apply search and filter logic to the list of vehicles in real-time.
        - Each vehicle card will be tappable, navigating to the detail screen.

5.  **Develop the Vehicle Detail Screen (`lib/screens/vehicle_detail_screen.dart`):**
    - This screen will display the complete, read-only details of a selected vehicle.
    - It will be presented when a user taps a vehicle card on the home screen.
    - **Details to Display:**
        - Name
        - Vehicle Number
        - Status
        - Location
        - Details/Description
        - Last Updated Timestamp

6.  **Launch & Preview:**
    - Run the new user app using `flutter run -t lib/main_user.dart` to showcase the revamped application.
