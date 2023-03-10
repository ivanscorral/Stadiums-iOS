# Stadiums-iOS

<p align="center">
  <img width="300" height="600" src="https://user-images.githubusercontent.com/17148950/224124080-dacc1338-001f-4464-9a40-24e427d4a304.png">
</p>

## Overview

Stadiums is an iOS app that lets users explore a list of touristic stadiums with ease. The app fetches a list of stadiums from a website and displays them as a list. It also has the following features:

- ⏳: Implement a detailed view that displays more information about the selected stadium (WIP)
- ✅: Detailed view when clicking on a stadium
- ✅: Implement search and filter functionality for the stadium list (WIP)
- ✅: Search bar for filtering stadiums
- ✅: Asynchronous image and list loading
- ✅: Uses Core Data to persist the stadium data fetched from the API
- ✅: Implement a development pattern (**we are using MVVM here**)

## Features

The app includes some additional features not asked for in the task:

* Navigation controller for pushing and popping viewcontrollers cleanly
* Swipe left to go back gestures
* Click on navigation title to scroll to the top of the list
* Functioning real time filtering with cancel button

## Roadmap

The following are the items in the roadmap for this project:

- ❌: Write unit tests for the app
- ⏳: Implement a detailed view that displays more information about the selected stadium (WIP)
- ⏳: Improve UI/UX for better user experience (WIP)
- ✅: Fetch the list of stadiums from https://sergiocasero.es/pois.json
- ✅: Store the fetched data using Core Data for persistent storage
- ✅: Display the list of stadiums in the app
- ✅: Implement search and filter functionality for the stadium list (WIP)


## Requirements

The following are the requirements for this project:

### Dependencies

| Library    | Version | Usage Justification                                       |
|------------|---------|-----------------------------------------------------------|
| Alamofire  | 5.4     | Used for making HTTP network requests to retrieve stadium data from the API. |
| Kingfisher | 6.3     | Used for downloading and caching stadium images in a memory-efficient way. |

Note: You may need to install these dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Add Package Dependency`.

### Software

* Xcode 14.2 or later

## Installation

1. Clone or download the repository.
2. Open the `Stadiums.xcodeproj` file in Xcode.
3. Install dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Resolve Package Versions`.
4. Run the app in a simulator or on a physical device by selecting a scheme and then clicking the Run button in Xcode.

## Contributing

Thank you for your interest in contributing to Stadiums-iOS. However, this is a private project for an interview, and contributions are not accepted at this time. Any contributions made will be rejected.

You are free to fork the repository and make your changes, following the terms of the GNU GPLv3 license.

## License

This project is licensed under the GNU GPLv3 license - see the LICENSE file for details.
