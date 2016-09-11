//
//  AppDelegate.swift
//  Example
//
//  Created by Dan Trenz on 2/18/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

import UIKit
import SettingsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // set the app version + build number in Settings
    Settings.set(.appVersion, "1.0.1")
    
    // set values/state for custom preference items
    Settings.set(.apiEnvironment, "Staging")
    Settings.set(.contrast, 80)
    Settings.set(.enableAnalytics, true)
    Settings.set(.favoriteColor, "#00FF00")
    Settings.set(.firstName, "Han")
    
    // retrieve the current setting values
    let name = Settings.get(.firstName)
    print("Hello, \(name).")
    
    // observe and respond to changes to any settings
    Settings.subscribe(.favoriteColor) { (newValue) -> Void in
      print("Favorite color was changed to \(newValue)")
    }
    
    return true
  }

}

