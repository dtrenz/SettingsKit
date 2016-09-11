//
//  Settings.swift
//  Example
//
//  Created by Dan Trenz on 9/11/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

import Foundation
import SettingsKit


enum Settings: String, SettingsKit {
    case appVersion
    case apiEnvironment
    case contrast
    case enableAnalytics
    case favoriteColor
    case firstName
}
