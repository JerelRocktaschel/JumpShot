# JumpShot
A framework for accessing the NBA API for iOS and macOS written in Swift.


# Summary
JumpShot is a framework for both iOS and macOS for accessing various resources in the NBA API.


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

Yes it is that easy.

# License
JumpShot is licensed under the MIT License. See the LICENSE file for more information.
