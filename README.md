

# MSwiftUINavigator

<p align="center">
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/onevcat/Kingfisher/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-black"></a>
<a href="http://www.apple.com/ios/"><img src="https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat"></a>
</p>


MSwiftUINavigator is a Swift package that provides a navigation solution for SwiftUI applications, leveraging the UIKit navigation system. It simplifies common navigation tasks and integrates seamlessly with SwiftUI views.

## Features

- Push views onto the navigation stack.
- Present views modally with custom transition and presentation styles.
- Dismiss views and navigate back.
- Pop to the root view.
- Present sheets with customizable sizes using the FittedSheets library.
- Present dialogs and action sheets above the current view.
- Pop to a specific view type in the navigation stack.
- Present dialogs and action sheets above the current view, with options for customizations.

## Installation

You can add MSwiftUINavigator to your Swift package by adding it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/MahmoudAbdelshafi/MSwiftUINavigator.git", .branch("main"))
],
```

## Usage

To use MSwiftUINavigator in your SwiftUI project, you'll need to import it and conform to the Navigator protocol in the main view where you want to use the navigator:

```swift
import MSwiftUINavigator

struct ContentView: View, Navigator {
    // Your view code here
}
```
Additionally, you can access the Navigator as an @Environment object:

```swift
@Environment(\.navigator) var navigator

navigator.presentSheet {
    // Your view code here
}

navigator.pushView {
    // Your view code here
}

```

For singleton access to the NavigationManager, you can use the shared instance like this:

```swift

NavigationManager.shared.presentView(transitionStyle: .coverVertical,
                                      presentStyle: .fullScreen,
                                      animated: true) {
                // Your View here
}

```


To present an action sheet, you can use the `presentActionSheet` function provided by MSwiftUINavigator:

```swift
navigator.presentActionSheet {
    ActionSheet(
        title: Text("Choose an action"),
        message: Text("What would you like to do?"),
        buttons: [
            .default(Text("Option 1")) {
                // Handle option 1
            },
            .default(Text("Option 2")) {
                // Handle option 2
            },
            .cancel()
        ]
    )
}
```

## Dependencies

MSwiftUINavigator relies on the following external dependency to enhance its functionality, particularly for handling popups, sheets, and dialogs:

- **FittedSheets**: FittedSheets is a powerful library available on [GitHub](https://github.com/gordontucker/FittedSheets) that provides advanced capabilities for presenting sheets with customizable sizes and behaviors. MSwiftUINavigator utilizes FittedSheets to create dynamic and interactive sheet presentations, enhancing the user experience when displaying popups, sheets, and dialogs in your SwiftUI applications.

## License

This package is released under the MIT License.

## Author

- **Mahmoud Abdelshafi**
  - GitHub: [github.com/MahmoudAbdelshafi](https://github.com/MahmoudAbdelshafi)
  - LinkedIn: [linkedin.com/in/mahmoud-abd-el-shafi](https://www.linkedin.com/in/mahmoud-abd-el-shafi/)


- **Soliman El Far**
  - GitHub: [github.com/aoliman](https://github.com/aoliman)
  - LinkedIn: [linkedin.com/in/soliman-yousry-74050a155/](https://www.linkedin.com/in/soliman-yousry-74050a155/)
