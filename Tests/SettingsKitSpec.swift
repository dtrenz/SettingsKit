import Nimble
import Quick

@testable import SettingsKit


enum Settings: SettingsKit {
  case ApiEnvironment, CityState, DateOfBirth, EnableAnalytics, EncodedString, LuckyNumber, SocialNetworks
  
  var identifier: String {
    switch self {
      case .ApiEnvironment:
        return "api_environment"
      case .CityState:
        return "city_state"
      case .DateOfBirth:
        return "date_of_birth"
      case .EnableAnalytics:
        return "enable_analytics"
      case .EncodedString:
        return "encoded_string"
      case .LuckyNumber:
        return "lucky_number"
      case .SocialNetworks:
        return "social_networks"
    }
  }
} 

class SettingsKitSpec: QuickSpec {
  override func spec() {
    
    describe("description") {
      
      it("returns a string representation of the setting value") {
        Settings.set(setting: .LuckyNumber, 23)
        
        expect(Settings.LuckyNumber.description) == "23"
      }
      
      it("returns a string representation of a nil setting value") {
        UserDefaults.standard.removeObject(forKey: Settings.LuckyNumber.identifier)
        
        expect(Settings.LuckyNumber.description) == "nil"
      }
      
    }
    
    describe("set() — convenience method") {
      
      context("when storing any supported Settings.bundle preference item value type") {
        
        it("can store an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .SocialNetworks, value)
          
            let result = UserDefaults.standard.array(forKey: identifier) as! [String]
          
          expect(result) == value
        }
        
        it("can store a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .EnableAnalytics, value)
          
            let result = UserDefaults.standard.bool(forKey: identifier)
          
          expect(result) == value
        }
        
        it("can store data") {
          let identifier = Settings.EncodedString.identifier
            let value = NSData(base64Encoded: "SGVsbG8gV29ybGQ=", options: []) as! NSData
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .EncodedString, value)
          
            let result = UserDefaults.standard.object(forKey: identifier) as! NSData
          
          expect(result) == value
        }
        
        it("can store a date") {
          let identifier = Settings.DateOfBirth.identifier
            let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
            let value = formatter.date(from: "1969-02-26")! as NSDate
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .DateOfBirth, value)
          
            let result = UserDefaults.standard.object(forKey: identifier) as! NSDate
          
          expect(result) == value
        }
        
        it("can store a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .CityState, value)
          
            let result = UserDefaults.standard.dictionary(forKey: identifier) as! [String: String]
          
          expect(result) == value
        }
        
        it("can store an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .LuckyNumber, value)
          
            let result = UserDefaults.standard.integer(forKey: identifier)
          
          expect(result) == value
        }
        
        it("can store a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
            UserDefaults.standard.removeObject(forKey: identifier)
          
            Settings.set(setting: .ApiEnvironment, value)
          
            let result = UserDefaults.standard.string(forKey: identifier)
          
          expect(result) == value
        }
        
      }
      
    }
    
    
    describe("get() — convenience method") {
      
      context("when fetching any supported Settings.bundle preference item value type") {
        
        it("can fetch an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .SocialNetworks) as! [String]
          
          expect(result) == value
        }
        
        it("can fetch a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .EnableAnalytics) as! Bool
          
          expect(result) == value
        }
        
        it("can fetch data") {
          let identifier = Settings.EncodedString.identifier
            let value = NSData(base64Encoded: "SGVsbG8gV29ybGQ=", options: []) as! NSData
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .EncodedString) as! NSData
          
          expect(result) == value
        }
        
        it("can fetch a date") {
          let identifier = Settings.DateOfBirth.identifier
            let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
            let value = formatter.date(from: "1969-02-26") as! NSDate
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .DateOfBirth) as! NSDate
          
          expect(result) == value
        }
        
        it("can fetch a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .CityState) as! [ String: String ]
          
          expect(result) == value
        }
        
        it("can fetch an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .LuckyNumber) as! Int
          
          expect(result) == value
        }
        
        it("can fetch a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
            UserDefaults.standard.set(value, forKey: identifier)
          
            let result = Settings.get(setting: .ApiEnvironment) as! String
          
          expect(result) == value
        }
        
      }
      
    }
    
    
    describe("subscribe() — convenience method") {
      
      context("when the observed setting changes") {
        
        it("the onChange closure is called") {
          var handlerWasCalled = false
          
            UserDefaults.standard.set(false, forKey: Settings.EnableAnalytics.identifier)
          
            Settings.subscribe(setting: .EnableAnalytics) { (newValue) -> Void in
            handlerWasCalled = true
          }
          
            UserDefaults.standard.set(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(handlerWasCalled).toEventually(beTrue())
        }
        
        it("the new value of the observed setting is passed to the onChange closure") {
          var result = false
          
            UserDefaults.standard.set(false, forKey: Settings.EnableAnalytics.identifier)
          
            Settings.subscribe(setting: .EnableAnalytics) { (newValue) -> Void in
            if let newValue = newValue as? Bool {
              result = newValue
            }
          }
          
            UserDefaults.standard.set(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(result).toEventually(beTrue())
        }
      }
      
    }
    
  }
}
