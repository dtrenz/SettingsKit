import SettingsKit


enum Settings: SettingsKit {
  case ApiEnvironment
  case AppVersion
  case Contrast
  case EnableAnalytics
  case FavoriteColor
  case FirstName
  
  var identifier: String {
    switch self {
      case .ApiEnvironment:
        return "api_environment"
      case .AppVersion:
        return "app_version"
      case .Contrast:
        return "contrast"
      case .EnableAnalytics:
        return "enable_analytics"
      case .FavoriteColor:
        return "favorite_color"
      case .FirstName:
        return "first_name"
    }
  }
}
