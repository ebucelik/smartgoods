# Use SwiftUI Framework

Date: 2022-12-09, Lisa-Marie Pleyer

## Status

Accepted

## Context

There are two main frameworks available which facilitate app development for iOS systems: SwiftUI and UIKit.

UIKit is an imperative framework published in 2008.
It allows the developer to build user interfaces that manage input and interactions between the system, the user and the application.

SwiftUI was launched in 2019 as a user interface toolkit enabling the development of an application in a declarative manner.
More emphasis is put on *what* should be on the screen rather than explicitly laying out views, as is the case in UIKit.
I.e., instead of having to detect changes and actively updating the user interface, SwiftUI calculates differences between states (states are defined as screen content changes) and automatically updates the representation shown to the user.

## Decision

We will use SwiftUI as our main framework.
SwiftUI is a modern framework which straightens many of the problems Apple saw developers experiencing with UIKit.
It is a powerful library which will continue to evolve as a powerful language and therefore represents the future of iOS app development.

Since backward compatibility for versions prior to iOS 13 is not required and there are currently no plans to include features unavailable in SwiftUI a more modern framework is a valid choice to guarantee an adequate solution for future iOS versions.
Additionally, SwiftUI is considered the fastest way to develop iOS applications as it generally requires much less code to achieve the same results as in UIKit.
Fast developing is further supported by SwiftUI’s Live Preview.

## Consequences

* **SwiftUI is a relatively new framework**: It is therefore considered less feature-complete.
* **SwiftUI and UIKit are not mutually exclusive**: Whenever functionality and features are missing from the new SwiftUI framework at the time of development it is possible to establish interfacing between SwiftUI and UIKit in the same application, although at the price of added complexity.
* **SwiftUI requires a minimum iOS version**: When using SwiftUI one must accept iOS 13 as the oldest supported iOS version.
* **Xcode Interface Builder is not supported anymore**: UIKit allowed the developer to build the entire user interface using a drag-and-drop interface builder, which was discarded in favor of Live Preview rendering code as you edit in SwiftUI.
