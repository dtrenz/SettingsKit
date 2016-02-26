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
  
  var description: String {
    guard let value = Self.get(self) else { return "nil" }
    
    return "\(value)"
  }
  
  func get() -> AnyObject? {
    return Self.get(self)
  }
  
  func set<T>(value: T) {
    Self.set(self, value)
  }
  
  static func get(setting: Self) -> AnyObject? {
    return NSUserDefaults.standardUserDefaults().objectForKey(setting.identifier)
  }
  
  static func set<T>(setting: Self, _ value: T) {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if let boolVal = value as? Bool {
      defaults.setBool(boolVal, forKey: setting.identifier)
    } else if let intVal = value as? Int {
      defaults.setInteger(intVal, forKey: setting.identifier)
    } else if let objectVal = value as? AnyObject {
      defaults.setObject(objectVal, forKey: setting.identifier)
    }
  }
  
}
