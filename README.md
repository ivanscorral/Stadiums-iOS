# Stadiums-iOS

<p align="center">
  <img width="300" height="600" src="https://user-images.githubusercontent.com/17148950/224124080-dacc1338-001f-4464-9a40-24e427d4a304.png">
</p>

## Overview

Stadiums is a simple iOS app that fetches a list of POIs from a website and displays them as a list. It also has the following features:

- [ ] Detailed view when clicking on a POI
- [x] Search bar for filtering
- [x] Asynchronous image and list loading
- [x] Uses Core Data to persist the data fetched from the API
- [x] Implement a development pattern (**we are using MVVM here**)

## Features

The app includes some additional features not asked for in the task:

* Navigation controller for pushing and popping viewcontrollers cleanly
* Swipe left to go back gestures
* Click on navigation title to scroll to the top of the list
* Functioning real time filtering with cancel button

## Roadmap

The following are the items in the roadmap for this project:

- [x] Implement main list UI
- [x] Add Kingfisher to SPM to fetch images
- [x] Implement search bar functionality
- [x] Image fetching 
- [ ] Detailed visualization
- [x] Fetching using Alamofire
- [x] Core data storage

## Requirements

The following are the requirements for this project:

* Xcode 14.2 or later
* Alamofire 
* Kingfisher 

Note: You may need to install these dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Add Package Dependency`.

## Installation

1. Clone or download the repository.
2. Open the `Stadiums.xcodeproj` file in Xcode.
3. Install dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Resolve Package Versions`.
4. Run the app in a simulator or on a physical device by selecting a scheme and then clicking the Run button in Xcode.

## Contributing

This is a private project for an interview, and contributing is not allowed. However, you are free to fork the repository and make your changes, following the terms of the GNU GPLv3 license.

## License

This project is licensed under the GNU GPLv3 license - see the LICENSE file for details.
