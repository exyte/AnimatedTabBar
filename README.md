<img src="https://raw.githubusercontent.com/exyte/media/master/common/header.png">
<table>
    <thead>
        <tr>
            <th>Floaters</th>
            <th>Toasts</th>
            <th>Popups</th>
            <th>Sheets</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <img src="https://raw.githubusercontent.com/exyte/media/master/AnimatedTabBar/1.gif" />
            </td>
            <td>
                <img src="https://raw.githubusercontent.com/exyte/media/master/AnimatedTabBar/2.gif" />
            </td>
            <td>
                <img src="https://raw.githubusercontent.com/exyte/media/master/AnimatedTabBar/3.gif" />
            </td>
            <td>
                <img src="https://raw.githubusercontent.com/exyte/media/master/AnimatedTabBar/4.gif" />
            </td>
        </tr>
    </tbody>
</table>

<p><h1 align="left">Animated Tab Bar</h1></p>

<p><h4>AnimatedTabBar is a tabbar with number of preset animations written in pure SwiftUI</h4></p>

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
1. Add an `Int` to store current selection    
2. Pass your buttons to AnimatedTabBar using one of 2 constructors. For this one you can pass any view types:  
```swift
import AnimatedTabBar

AnimatedTabBar(selectedIndex: $selectedIndex) {
    TabButton1()
    TabButton2()
    TabButton3()
}
```
Views for this one must have the same type, or manually converted to any view
```swift
AnimatedTabBar(selectedIndex: $selectedIndex, views: [TabButton1(), TabButton2(), TabButton3()])
```

### Required parameters 
`selectedIndex` - binding to current index     
`views` - buttons to display in a tabbar  

### Available customizations - modifiers
use `customize` closure in popup modifier:

`barColor` - Color of the tabbar itself
`selectedColor` - Selected tab color (use template rendering for this color to be applied properly)    
`unselectedColor` - Unselected tab color     
`ballColor` - Ball indicator color    
`verticalPadding` - Space from buttons to bar's top and bottom edges    
`cornerRadius` - Applied to tabbar background color     
`ballAnimation` - Default is .easeOut(duration: 0.6): Animation curve to apply to ball motion   
`indentAnimation` - Animation curve for growing/shrinking of the indent in the tabbar       
`buttonsAnimation` - Animation curve for applying color to tab buttons    

`ballTrajectory` - Options for ball indicator animation paths:     
- `parabolic`  - Jump to selected button following a parabolic arc     
- `straight` - Slide to selected tab        

### Built-in animatable tab buttons
By default tabs only have a simple animation of color, but you can customize that. This library has two built-in button types you can use out-of-the-box: `DropletButton` and `WiggleButton`, and a super custom `ColorButton` type in Example project. Please feel free to use them in your projects or build your own buttons on top of them.

## Examples

To try AnimatedTabBar examples:
- Clone the repo `https://github.com/exyte/AnimatedTabBar.git`
- Open terminal and run `cd <AnimatedTabBarRepo>/Example/`
- Run `pod install` to install all dependencies
- Run open `AnimatedTabBarExample.xcworkspace/` to open project in the Xcode
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

* iOS 14+
* Xcode 12+ 

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
