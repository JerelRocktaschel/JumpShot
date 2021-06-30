# JumpShot
A framework for accessing the NBA API for iOS and macOS written in Swift.


# Summary
JumpShot is a framework for both iOS and macOS for accessing various resources in the NBA API.

# Cocoapods
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate JumpShot into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'JumpShot', :git => 'https://github.com/JerelRocktaschel/JumpShot.git', :tag => '1.0.0'
```

# How to get NBA data into your app in 3 EASY STEPS!

1. Import the JumpShot framework.

```Swift
import JumpShot
```

2. Instantiate an instance of JumpShot.

```Swift
let jumpShot = JumpShot()
```

3. Call a JumpShot function and handle the response via a closure.

```Swift
jumpShot.getTeams { teams, error in
    guard error == nil else {
        print(error!)
        return
    }

    guard let teams = teams else {
        print("No teams returned.")
        return
    }

    print(teams)
}
```

Yes it is that easy!

# License
JumpShot is licensed under the MIT License. See the LICENSE file for more information.

# Thanks for looking!
If you do end up using JumpShot, I'd love to hear about it!
