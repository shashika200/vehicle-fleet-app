# Vehicle Tracking App Blueprint

## Overview

This document outlines the architecture and features of the Vehicle Tracking App, a Flutter project with two main components: an Admin App for managing the vehicle fleet and a User App for viewing available vehicles.

## Project Structure

The project is organized into two separate applications:

*   **Admin App:** Allows administrators to perform CRUD (Create, Read, Update, Delete) operations on the vehicle data.
*   **User App:** Allows users to view and search for available vehicles.

Both apps share the same Firebase backend and data models.

## Features

### Admin App

*   **Authentication:** Secure login for administrators using Firebase Authentication.
*   **Vehicle Management:**
    *   View a list of all vehicles in the fleet.
    *   Add new vehicles with details such as name, type, location, and status.
    *   Edit existing vehicle information.
    *   Delete vehicles from the fleet.
*   **Real-time Updates:** The vehicle list is updated in real-time using Firestore streams.

### User App

*   **Vehicle Listings:** Displays a list of all available vehicles.
*   **Search Functionality:** Allows users to search for vehicles by name or type.
*   **Vehicle Details:** Tapping on a vehicle reveals a detailed view with more information.
*   **Real-time Status:** Vehicle availability is shown in real-time.

## Design

*   **UI:** The app follows Material Design principles for a clean and intuitive user interface.
*   **Styling:**
    *   The **Admin App** uses a `red` color scheme to distinguish it as a management tool.
    *   The **User App** uses a `blue` color scheme for a more user-friendly feel.
*   **Layout:** Both apps are designed to be responsive and work well on various screen sizes.

## Current Implementation Plan

This section outlines the current development phase.

### Phase 1: Core Functionality (Completed)

*   **DONE:** Set up Firebase project and configure for Flutter.
*   **DONE:** Define the `Vehicle` data model.
*   **DONE:** Implement the Admin App with full CRUD functionality for vehicles.
*   **DONE:** Implement the User App with vehicle listing and search capabilities.
*   **DONE:** Add a details screen for individual vehicles in the User App.
