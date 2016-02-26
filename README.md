# SettingsKit

[![CI Status](http://img.shields.io/travis/dtrenz/SettingsKit.svg?style=flat)](https://travis-ci.org/dtrenz/SettingsKit)
[![Version](https://img.shields.io/cocoapods/v/SettingsKit.svg?style=flat)](http://cocoapods.org/pods/SettingsKit)
[![License](https://img.shields.io/cocoapods/l/SettingsKit.svg?style=flat)](http://cocoapods.org/pods/SettingsKit)
[![Platform](https://img.shields.io/cocoapods/p/SettingsKit.svg?style=flat)](http://cocoapods.org/pods/SettingsKit)
[![Sponsored by Detroit Labs](https://img.shields.io/badge/sponsor-Detroit%20Labs-000000.svg?style=flat)](http://www.detroitlabs.com)

`SettingsKit` is a small library that makes it very simple to add useful app metadata
(i.e. app version & build number) information to the iOS Settings screen for
your app.


## Installation

`SettingsKit` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SettingsKit"
```

## Setup

In order to add custom items to Settings your app must have a Settings bundle
with a `Root.plist`. To fetch, update, and/or observe settings you will need to
add the settings you would like to use to the "Preference Items" array in your
`Settings.bundle/Root.plist`.

Once you have added one or more preference items, build your project to have
`SettingsKit` generate a `Settings.swift` file from your `Root.plist`.

> **Important** — Anytime you change the preference items in your `Root.plist`
you will need build your project to generate an updated `Settings.swift` file.


## Usage

Any preference items in your `Settings.bundle` will be available in a `Settings`
enum:

```swift
// set values/state for custom preference items
Settings.set(.AppVersion, "1.0.1")
Settings.set(.ApiEnvironment, "Staging")
Settings.set(.Contrast, 80)
Settings.set(.EnableAnalytics, true)
Settings.set(.FavoriteColor, "#00FF00")
Settings.set(.FirstName, "Han")

// retrieve the current setting values
let name = Settings.get(.FirstName)
print("Hello, \(name).")

// observe and respond to any changes made to a given setting
Settings.subscribe(.FavoriteColor) { (newValue) -> Void in
  print("Favorite color was changed to \(newValue)")
}
```


## Author

Dan Trenz ([@dtrenz](http://www.twitter.com/dtrenz)) c/o [Detroit Labs](http://www.detroitlabs.com)


## License

SettingsKit is available under the Apache License, Version 2.0. See the LICENSE file for more info.
