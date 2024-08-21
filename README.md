# API Inventory Management Frontend

## Overview

This project is a frontend application built using Flutter, designed for managing API inventories. The application provides a user-friendly interface for interacting with the backend API, allowing users to monitor, manage, and analyze API requests and responses.

## Features

- **API Management**: View and manage a list of APIs, including details like endpoints, usage statistics, and request logs.
- **Real-Time Monitoring**: Track API performance and usage in real-time.
- **User Authentication**: Secure login functionality integrated with the backend.
- **Responsive Design**: Optimized for both mobile and web platforms.

## Prerequisites

Before you start, ensure you have the following installed:

- **Flutter SDK**: Download and install from [flutter.dev](https://flutter.dev/).
- **Dart SDK**: Included with Flutter.
- **Android Studio or VS Code**: Recommended for development and debugging.
- **Backend API Server**: Ensure the backend API server is running and accessible.

## Installation

1. **Installation**:
```bash
   Install Flutter:
   Follow the official Flutter installation guide based on your operating system:
   https://flutter.dev/get-started/
```

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/KomalJain2607/api_management_.git
   ```

3. **Navigate to the Project Directory**:
   ```bash
   cd api_management_
   ```

4. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

5. **Update `pubspec.yaml`**:
   Ensure all required dependencies are listed in the `pubspec.yaml` file:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     http: ^0.13.3
     provider: ^6.0.0
   ```

## Running the Application

To run the application on your preferred platform:

1. **For Android/iOS**:
   Connect your device or start an emulator, then run:
   ```bash
   flutter run
   ```

2. **For Web**:
   Ensure you have Chrome installed, then run:
   ```bash
   flutter run -d chrome
   ```

## Folder Structure

- **lib**: Contains all the Dart code for the application.
  - **config**: Configuration files and constants.
  - **models**: Data models used in the app.
  - **providers**: State management using the provider package.
  - **screens**: UI screens of the application.
  - **services**: API service classes for managing HTTP requests.
  - **widgets**: Reusable UI components.

## API Integration

The frontend interacts with the backend API for inventory management, making use of HTTP requests to fetch, update, and delete API records. The base URL and API key are configured in the `config.dart` file.

## Deployment

To build the app for production:

1. **For Mobile**:
   ```bash
   flutter build apk --release
   ```
   or
   ```bash
   flutter build ios --release
   ```

2. **For Web**:
   ```bash
   flutter build web --release
   ```

The build outputs will be in the `build/` directory.
