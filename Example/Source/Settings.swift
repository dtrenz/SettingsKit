//
//  Settings.swift
//  Example
//
//  Created by Dan Trenz on 9/11/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

import Foundation
import SettingsKit


enum Settings: SettingsKit {
    case appVersion
    case apiEnvironment
    case contrast
    case enableAnalytics
    case favoriteColor
    case firstName
    
    var identifier: String {
        switch self {
        case .appVersion:
            return "app_version"
        case .apiEnvironment:
            return "api_environment"
        case .contrast:
            return "contrast"
        case .enableAnalytics:
            return "enable_analytics"
        case .favoriteColor:
            return "favorite_color"
        case .firstName:
            return "first_name"
        }
    }
}
