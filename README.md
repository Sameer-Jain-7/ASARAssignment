# ASARAssignment

## Overview
ASARAssignment is an iOS application developed as part of an assignment project. The project is built using Swift and UIKit, and it includes various features such as custom UI components, integration with external libraries using CocoaPods, and dynamic data handling.

## Features
- Custom tab bar with a blurred background effect.
- Dynamic event details view with multiple interactive components.
- Horizontal scrolling collection view with custom cards.
- Integration with CocoaPods for managing external dependencies.

## Requirements
- iOS 17.2+
- Xcode 15.0+
- Swift 5.0+
- CocoaPods

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/ASARAssignment.git
cd ASARAssignment
```

### 2. Install Dependencies
This project uses CocoaPods for dependency management. Make sure CocoaPods is installed on your machine. If not, you can install it using:
```bash
sudo gem install cocoapods
```

After ensuring CocoaPods is installed, navigate to the project directory and run:
```bash
pod install
```

### 3. Open the Project in Xcode
Open the `.xcworkspace` file in Xcode:
```bash
open ASARAssignment.xcworkspace
```

### 4. Build and Run the Project
Select your target device or simulator, then build and run the project using Xcode.

## Project Structure
- `ASARAssignment/`: Main project directory containing all source files.
- `ASARAssignment.xcworkspace`: Workspace file that integrates the Xcode project with CocoaPods.
- `Podfile`: CocoaPods configuration file listing the dependencies for the project.
- `README.md`: Project documentation (this file).

## Dependencies
- [CocoaPods](https://cocoapods.org/): Dependency manager for Swift and Objective-C Cocoa projects.
