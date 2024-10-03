# StyleSwap
StyleSwap is a prototype android application which provides a convenient and seemless interface for users to swap their clothes.

The application is built on flutter which allows for the application to be easily expanded to be cross platform in future iterations.

The following guide will walk you through installing the application and debugging it.

## Prerequisites

- Git
- Flutter SDK
- Android Studio

## Steps

### 1. Clone the Flutter Project from GitHub

1. Open GitHub and navigate to the repository you want to clone.
2. Click the **Code** button and copy the repository URL.
3. Open a terminal and run the following command to clone the repository:

    ```bash
    git clone <repository-url>
    ```

4. Navigate to the cloned directory:

    ```bash
    cd <repository-directory>
    ```

### 2. Install Flutter SDK

1. Download the Flutter SDK from the official Flutter website.
2. Extract the downloaded file and add the `flutter/bin` directory to your system's PATH.

### 3. Install Android Studio

1. Download and install Android Studio from the official website.
2. Open Android Studio and follow the setup wizard to install the necessary SDKs and tools.
3. Install the Flutter and Dart plugins:
    - Go to **File > Settings > Plugins**.
    - Search for "Flutter" and click **Install**.
    - Search for "Dart" and click **Install**.
    - Restart Android Studio.

### 4. Set Up an Android Emulator

1. Open Android Studio and go to **AVD Manager** (Android Virtual Device Manager) from the toolbar.
2. Click **Create Virtual Device**.
3. Select a device definition and click **Next**.
4. Choose a system image and click **Next**.
5. Verify the configuration and click **Finish**.
6. Start the emulator by clicking the **Play** button next to your virtual device.

### 5. Run the Flutter Application

1. Open the cloned Flutter project in Android Studio:
    - Go to **File > Open** and select the project directory.
2. Open a terminal in Android Studio and run the following command to get the dependencies:

    ```bash
    flutter pub get
    ```

3. Run the application:

    ```bash
    flutter run
    ```

### 6. Debug the Flutter Application

1. Set breakpoints in your Dart code by clicking in the left margin of the code editor.
2. Start debugging by clicking the **Debug** button in the toolbar or by running:

    ```bash
    flutter run --debug
    ```

3. Use the **Flutter Inspector** and **DevTools** for advanced debugging and performance profiling.

## Additional Resources

- Flutter Documentation
- Android Studio Documentation

### Attribution
The readme for flutter was originally generated using AI and then modified to match our application.

