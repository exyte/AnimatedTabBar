![header](https://user-images.githubusercontent.com/9447630/217482844-e5f420cf-7aa2-4684-8238-54064bbb23ba.png)
![demo](https://user-images.githubusercontent.com/9447630/217482148-8594b3ce-e6be-4e84-a65d-29915566a61a.gif)

<p><h1 align="left">Animated Tab Bar</h1></p>

<p><h4>AnimatedTabBar is a tabbar with a number of preset animations written in pure SwiftUI</h4></p>

___

<p> We are a development agency building
  <a href="https://clutch.co/profile/exyte#review-731233?utm_medium=referral&utm_source=github.com&utm_campaign=phenomenal_to_clutch">phenomenal</a> apps.</p>

</br>

<a href="https://exyte.com/contacts"><img src="https://i.imgur.com/vGjsQPt.png" width="134" height="34"></a> <a href="https://twitter.com/exyteHQ"><img src="https://i.imgur.com/DngwSn1.png" width="165" height="34"></a>

</br></br>

[![Twitter](https://img.shields.io/badge/Twitter-@exyteHQ-blue.svg?style=flat)](http://twitter.com/exyteHQ)
[![Version](https://img.shields.io/cocoapods/v/ExyteAnimatedTabBar.svg?style=flat)](http://cocoapods.org/pods/ExyteAnimatedTabBar)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-0473B3.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ExyteAnimatedTabBar.svg?style=flat)](http://cocoapods.org/pods/ExyteAnimatedTabBar)
[![Platform](https://img.shields.io/cocoapods/p/ExyteAnimatedTabBar.svg?style=flat)](http://cocoapods.org/pods/ExyteAnimatedTabBar)

# Usage
1. Add an `Int` to store the current selection    
2. Pass your buttons to the AnimatedTabBar using one of 2 initializers. For the first one you can pass any view type:  
```swift
import AnimatedTabBar

AnimatedTabBar(selectedIndex: $selectedIndex) {
    TabButton1()
    TabButton2()
    TabButton3()
}
```

For the second one the views must have the same type, or be manually converted to `AnyView`
```swift
AnimatedTabBar(selectedIndex: $selectedIndex, views: [TabButton1(), TabButton2(), TabButton3()])
```

### Required parameters 
`selectedIndex` - binding to the current index     
`views` - buttons to display in the tabbar  

### Available customizations - modifiers
use the `customize` closure in the popup modifier:

`barColor` - Color of the tabbar itself      
`selectedColor` - Selected tab color (use template rendering for this color to be applied properly)    
`unselectedColor` - Unselected tab color     
`ballColor` - Ball indicator color    
`verticalPadding` - Space from the buttons to the bar's top and bottom edges    
`cornerRadius` - The corner radius applied to the tabbar background color     
`ballAnimation` - Animation curve to apply to ball motion, default is .easeOut(duration: 0.6)
`indentAnimation` - Animation curve for growing/shrinking of the indent in the tabbar       
`buttonsAnimation` - Animation curve for applying color to tab buttons    

`ballTrajectory` - Options for ball indicator animation paths:     
- `parabolic`  - Jump to the selected button following a parabolic arc     
- `teleport` - Disappear and quickly re-appear above selected tab
- `straight` - Slide to the selected tab        

### Built-in animatable tab buttons
By default tabs only have a simple color animation, but you can customize that. This library has two built-in button types you can use out-of-the-box: `DropletButton` and `WiggleButton`, and a super custom `ColorButton` type in the Example project. Please feel free to use them in your projects or build your own buttons on top of them.

## Examples

To try the AnimatedTabBar examples:
- Clone the repo `https://github.com/exyte/AnimatedTabBar.git`
- Open terminal and run `cd <AnimatedTabBarRepo>/Example/`
- Run `pod install` to install all dependencies
- Run `open AnimatedTabBarExample.xcworkspace/` to open the project in Xcode
- Try it!

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/exyte/AnimatedTabBar.git")
]
```

### [CocoaPods](http://cocoapods.org)

To install `AnimatedTabBar`, simply add the following line to your Podfile:

```ruby
pod 'ExyteAnimatedTabBar'
```

### [Carthage](http://github.com/Carthage/Carthage)

To integrate `AnimatedTabBar` into your Xcode project using Carthage, specify it in your `Cartfile`

```ogdl
github "Exyte/AnimatedTabBar"
```

## Requirements

* iOS 16+
* Xcode 14+ 

## Acknowledgements

Many thanks to [Yeasin Arafat](https://dribbble.com/shots/14883627-Tab-Bar-Animation) for their beautiful original work that we recreated with SwiftUI.

## Our other open source SwiftUI libraries
[PopupView](https://github.com/exyte/PopupView) - Toasts and popups library    
[Grid](https://github.com/exyte/Grid) - The most powerful Grid container    
[ScalingHeaderScrollView](https://github.com/exyte/ScalingHeaderScrollView) - A scroll view with a sticky header which shrinks as you scroll.    
[MediaPicker](https://github.com/exyte/mediapicker) - Customizable media picker     
[ConcentricOnboarding](https://github.com/exyte/ConcentricOnboarding) - Animated onboarding flow    
[FloatingButton](https://github.com/exyte/FloatingButton) - Floating button menu    
[ActivityIndicatorView](https://github.com/exyte/ActivityIndicatorView) - A number of animated loading indicators    
[ProgressIndicatorView](https://github.com/exyte/ProgressIndicatorView) - A number of animated progress indicators    
[SVGView](https://github.com/exyte/SVGView) - SVG parser    
[LiquidSwipe](https://github.com/exyte/LiquidSwipe) - Liquid navigation animation    
