//
//  SettingsKit.swift
//  About
//
//  Created by Dan Trenz on 2/25/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

public protocol SettingsKit: CustomStringConvertible {
  var identifier: String { get }
}

public extension SettingsKit {
  
  typealias SettingChangeHandler = (newValue: AnyObject?) -> Void
  
  var description: String {
    guard let value = Self.get(self) else { return "nil" }
    
    return "\(value)"
  }
  
  private var defaults: NSUserDefaults { return NSUserDefaults.standardUserDefaults() }
  
  // MARK: - Static Convenience Methods
  
  static func get(setting: Self) -> AnyObject? {
    return setting.get()
  }
  
  static func set<T>(setting: Self, _ value: T) {
    setting.set(value)
  }
  
  static func subscribe(setting: Self, onChange: SettingChangeHandler) {
    setting.subscribe(onChange)
  }
  
  // MARK: - Instance Methods
  
  private func get() -> AnyObject? {
    return defaults.objectForKey(identifier)
  }
  
  private func set<T>(value: T) {
    if let boolVal = value as? Bool {
      defaults.setBool(boolVal, forKey: identifier)
    } else if let intVal = value as? Int {
      defaults.setInteger(intVal, forKey: identifier)
    } else if let objectVal = value as? AnyObject {
      defaults.setObject(objectVal, forKey: identifier)
    }
  }
  
  private func subscribe(onChange: SettingChangeHandler) {
    let center = NSNotificationCenter.defaultCenter()
    
    center.addObserverForName(NSUserDefaultsDidChangeNotification, object: defaults, queue: nil) { (notif) -> Void in
      if let defaults = notif.object as? NSUserDefaults {
        onChange(newValue: defaults.objectForKey(self.identifier))
      }
    }
  }
  
}
