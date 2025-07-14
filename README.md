# PandaScoreApp

**PandaScoreApp** is an iOS application that displays CS\:GO matches happening across various tournaments worldwide, using the PandaScore API.

---

## Overview

* **Splash Screen**: displays the app logo on launch.
* **Main Screen (Matches List)**: shows upcoming and ongoing matches from the current date:

  * Match statuses: Scheduled, In Progress, Ended
  * Sorting: matches in progress appear at the top
  * Pull-to-refresh and pagination (20 items per page)
* **Match Detail Screen**: shows additional information for a selected match:

  * Team names (Team 1 vs. Team 2)
  * Local date and time of the match
  * Player list for each team (name, nickname, and photo)

## Technologies & Architecture

* **Language**: Swift
* **UI Framework**: SwiftUI
* **Architecture Pattern**: MVVM
* **Reactive Framework**: Combine
* **Testing**: XCTest (unit tests)

## Requirements

* Xcode 14.0 or later
* iOS 15.0 or later
* Swift 5.6 or later
* Internet connection to fetch data from the PandaScore API

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/PandaScoreApp.git
   ```
2. Open the project in Xcode:

   ```bash
   cd PandaScoreApp
   open PandaScoreApp.xcodeproj
   ```
3. Install dependencies via Swift Package Manager.
4. Add your PandaScore API key in `Constants.swift`:

   ```swift
   struct Api {
       static let key = "YOUR_API_TOKEN"
   }
   ```

## Running the App

1. Select a simulator or physical device.
2. Press **⌘R** to build and run the app.
3. On first launch, the splash screen appears before loading the matches list.

## MVVM Architecture

1. **View**: SwiftUI views that observe and render state from the ViewModel.
2. **ViewModel**: orchestrates network calls via Services and exposes reactive properties.
3. **Service**: protocols and implementations for HTTP requests using URLSession and Combine.
4. **Model**: data structures mapping JSON from the PandaScore API.

## PandaScore API

* General documentation: [https://developers.pandascore.co/docs/introduction](https://developers.pandascore.co/docs/introduction)
* Authentication: [https://developers.pandascore.co/docs/authentication](https://developers.pandascore.co/docs/authentication)
* CS\:GO endpoints: `/csgo/matches`, `/csgo/matches/{id}/players`

## Tests

* Run all unit tests in Xcode with **⌘U**.
* Coverage includes ViewModels and Services.

## Design

UI layouts and visual specifications follow the provided design guidelines.
