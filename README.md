# Currency Conversion App
## Overview
This Currency Conversion App is designed to provide users with a seamless experience for converting currencies, visualizing conversion history, and exploring currency suggestions. The app utilizes various technologies, including RxSwift for reactive programming, UserDefaults for data persistence, UIKit and SwiftUI for UI components, URLSession for network requests, and algorithmic skills for efficient currency conversion.

## Features
### Currency Conversion
Users can initiate currency conversion by selecting the source and target currencies from a customizable list.
The amount to be converted is entered via a debounced UITextField, ensuring smooth and efficient conversions.
### Data Persistence
Conversion history is persisted locally using UserDefaults, allowing users to view their past conversions even after app restarts.
Network calls are cached, and the app checks the timestamp of the cached data. If the data is within the last hour, the cached result is used to avoid unnecessary network calls.
### Detail View
The Detail View consists of a top section displaying a currency conversion chart using SwiftUI.
The bottom section is divided into two equal views:
The left view showcases the conversion history for the last 3 days.
The right view displays currency suggestions for ten different currencies based on the selected currency from the left view.
An empty state is displayed when the user hasn't performed any conversion yet.
### Responsive UI
The app is designed to be responsive and adaptive, providing a consistent user experience in both portrait and landscape orientations.
### Screenshots

Caption: Currency conversion screen with UIPickerView for currency selection.
![image](https://github.com/Korede612/Currency/assets/109530097/366e06e5-b38b-47a9-93d1-dab11f4df77d)



Caption: Detail view with a currency conversion chart and history for the last 3 days.
![image](https://github.com/Korede612/Currency/assets/109530097/f48eafe8-dd45-46d8-b998-32ac3e039736)



Caption: Currency suggestions based on the selected currency from the history view.
![image](https://github.com/Korede612/Currency/assets/109530097/df25c66b-9299-4fb8-b9e5-68da9516bf81)


Caption: Detail view with an empty state.
![image](https://github.com/Korede612/Currency/assets/109530097/af350329-ff30-40ff-a09d-1ecfd65de503)


## Dependencies
- RxSwift
- UIKit
- SwiftUI
## Installing Dependencies with CocoaPods
1. Make sure you have CocoaPods installed. If not, you can install it using the following command:
   ```
   gem install cocoapods
   ```
2. Navigate to the project directory containing your Podfile.
3. Run the following command to install the dependencies:
   ```
   pod install
   ```
4. After the installation is complete, open the .xcworkspace file to work on your project.

## How to Build and Run
- Clone the repository.
- Open the generated .xcworkspace file in Xcode.
- Build and run the app on a simulator or device.

