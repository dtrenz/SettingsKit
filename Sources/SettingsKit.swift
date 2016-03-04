//
//  SettingsKit.swift
//  About
//
//  Created by Dan Trenz on 2/25/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

/**
*  Protocol for the SettingsKit enum
*/
public protocol SettingsKit: CustomStringConvertible {
  /// The identifier string for the Settings preference item
  var identifier: String { get }
}

// SettingsKit enum extension (a/k/a "where the magic happens")
public extension SettingsKit {

  /// Convenience typealias for subscribe() onChange closure
  public typealias SettingChangeHandler = (newValue: AnyObject?) -> Void

  /// String description of the enum value
  public var description: String {
    guard let value = Self.get(self) else { return "nil" }

    return "\(value)"
  }
  
  /// Local defaults reference
  private var defaults: NSUserDefaults { return NSUserDefaults.standardUserDefaults() }
  
  
  // MARK: - Static Convenience Methods

  /**
  Fetch the current value for a given setting.
  
  - Parameter setting: The setting to fetch
  
  - Returns: The current setting value
  */
  public static func get(setting: Self) -> AnyObject? {
    return setting.get()
  }

  /**
   Update the value of a given setting.
   
   - Parameters:
     - setting: The setting to update
     - value:   The value to store for the setting
   */
  public static func set<T>(setting: Self, _ value: T) {
    setting.set(value)
  }

  /**
   Observe a given setting for changes. The `onChange` closure will be called,
   with the new setting value, whenever the setting value is changed either 
   by the user, or progammatically.
   
   - Parameters:
     - setting:  The setting to observe
     - onChange: The closure to call when the setting's value is updated
   */
  public static func subscribe(setting: Self, onChange: SettingChangeHandler) {
    setting.subscribe(onChange)
  }

  // MARK: - Instance Methods
  
  /**
  Fetch the current value for a given setting.
  
  __This is the instance method that is called by the static convenience method
  in the public API.__
  
  - Returns: The current setting value
  */
  private func get() -> AnyObject? {
    return defaults.objectForKey(identifier)
  }
  
  /**
   Update the value of a given setting.
   
   > This is the instance method that is called by the static convenience method
   in the public API.
   
   - Parameter value: The value to store for the setting
   */
  private func set<T>(value: T) {
    if let boolVal = value as? Bool {
      defaults.setBool(boolVal, forKey: identifier)
    } else if let intVal = value as? Int {
      defaults.setInteger(intVal, forKey: identifier)
    } else if let objectVal = value as? AnyObject {
      defaults.setObject(objectVal, forKey: identifier)
    }
  }
  
  
  /**
   Observe a given setting for changes. The `onChange` closure will be called,
   with the new setting value, whenever the setting value is changed either
   by the user, or progammatically.
   
   > This is the instance method that is called by the static convenience method
   in the public API.
   
   - Parameter onChange: The closure to call when the setting's value is updated
   */
  private func subscribe(onChange: SettingChangeHandler) {
    let center = NSNotificationCenter.defaultCenter()

    center.addObserverForName(NSUserDefaultsDidChangeNotification, object: defaults, queue: nil) { (notif) -> Void in
      if let defaults = notif.object as? NSUserDefaults {
        onChange(newValue: defaults.objectForKey(self.identifier))
      }
    }
  }

}
