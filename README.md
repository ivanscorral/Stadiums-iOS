# Stadiums-iOS

<p align="center">
  <img width="300" height="600" src="https://user-images.githubusercontent.com/17148950/224367924-582869bc-e773-45fd-b0b8-3f9cb4024d66.png">
</p>

## Overview

Stadiums is an iOS app that lets users explore a list of touristic stadiums with ease. The app fetches a list of stadiums from a website and displays them as a list. It also has the following features:

- ✅: Implement search and filter functionality for the stadium list
- ✅: Asynchronous image and list loading
- ✅: Uses Core Data to persist the stadium data fetched from the API
- ✅: Implement a development pattern (**we are using MVVM here**)
- ✅: Functioning real-time filtering with cancel button
- ✅: Swipe left to go back gestures
- ✅: Click on navigation title to scroll to the top of the list
- ✅: Button to open the selected stadium on Apple Maps

## Roadmap

The following are the items in the roadmap for this project:

- ⏳: Write unit tests for the app (Optional)
- ✅: Improve UI/UX for better user experience 
- ✅: Fetch the list of stadiums from https://sergiocasero.es/pois.json
- ✅: Store the fetched data using Core Data for persistent storage
- ✅: Display the list of stadiums in the app

## Requirements

The following are the requirements for this project:

### Dependencies

| Library    | Version | Usage Justification                                       |
|------------|---------|-----------------------------------------------------------|
| Alamofire  | >= 6.0  | Used for making HTTP network requests to retrieve stadium data from the API. |
| Kingfisher | >= 7.0  | Used for downloading and caching stadium images in a memory-efficient way. |

Note: You may need to install these dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Add Package Dependency`.

### Software

* Xcode 14.2 or later

### Devices and iOS versions tested 

* iPhone 14 Pro with iOS 16.3.1
* iPhone 14 Pro Simulator with iOS 16.2 

## Installation

1. Clone or download the repository.
2. Open the `Stadiums.xcodeproj` file in Xcode.
3. Install dependencies using Swift Package Manager. To do this, go to `File > Swift Packages > Resolve Package Versions`.
4. Run the app in a simulator or on a physical device by selecting a scheme and then clicking the Run button in Xcode.

## Contributing

Thank you for your interest in contributing to Stadiums-iOS. However, this is a private project for an interview, and contributions are not accepted at this time. Any contributions made will be rejected.

You are free to fork the repository and make your changes, following the terms of the GNU GPLv3 license.

## Acknowledgements

I would like to thank the creators and contributors of the libraries used in this project:

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Kingfisher](https://github.com/onevcat/Kingfisher)

Thanks to the creators and maintainers of these libraries for providing them free of charge and contributing to the open-source community.


## License

This project is licensed under the GNU GPLv3 license - see the LICENSE file for details.
