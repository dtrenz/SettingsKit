import Quick
import Nimble

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
        Settings.set(.LuckyNumber, 23)
        
        expect(Settings.LuckyNumber.description) == "23"
      }
      
      it("returns a string representation of a nil setting value") {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(Settings.LuckyNumber.identifier)
        
        expect(Settings.LuckyNumber.description) == "nil"
      }
      
    }
    

    describe("set()") {
      
      context("when storing any supported Settings.bundle preference item value type") {
      
        it("can store an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.SocialNetworks.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().arrayForKey(identifier) as! [String]
          
          expect(result) == value
        }
        
        it("can store a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.EnableAnalytics.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().boolForKey(identifier)
          
          expect(result) == value
        }
        
        it("can store data") {
          let identifier = Settings.EncodedString.identifier
          let value = NSData(base64EncodedString: "SGVsbG8gV29ybGQ=", options: []) as NSData!
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.EncodedString.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as! NSData
          
          expect(result) == value
        }
        
        it("can store a date") {
          let identifier = Settings.DateOfBirth.identifier
          let formatter = NSDateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
          let value = formatter.dateFromString("1969-02-26") as NSDate!
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.DateOfBirth.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as! NSDate
          
          expect(result) == value
        }
        
        it("can store a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.CityState.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().dictionaryForKey(identifier) as! [String: String]
          
          expect(result) == value
        }
        
        it("can store an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.LuckyNumber.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().integerForKey(identifier)
          
          expect(result) == value
        }
        
        it("can store a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.ApiEnvironment.set(value)
          
          let result = NSUserDefaults.standardUserDefaults().stringForKey(identifier)
          
          expect(result) == value
        }
        
      }
      
    }
    
    
    describe("set() — convenience method") {
      
      context("when storing any supported Settings.bundle preference item value type") {
        
        it("can store an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.SocialNetworks, value)
          
          let result = NSUserDefaults.standardUserDefaults().arrayForKey(identifier) as! [String]
          
          expect(result) == value
        }
        
        it("can store a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.EnableAnalytics, value)
          
          let result = NSUserDefaults.standardUserDefaults().boolForKey(identifier)
          
          expect(result) == value
        }
        
        it("can store data") {
          let identifier = Settings.EncodedString.identifier
          let value = NSData(base64EncodedString: "SGVsbG8gV29ybGQ=", options: []) as NSData!
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.EncodedString, value)
          
          let result = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as! NSData
          
          expect(result) == value
        }
        
        it("can store a date") {
          let identifier = Settings.DateOfBirth.identifier
          let formatter = NSDateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
          let value = formatter.dateFromString("1969-02-26") as NSDate!
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.DateOfBirth, value)
          
          let result = NSUserDefaults.standardUserDefaults().objectForKey(identifier) as! NSDate
          
          expect(result) == value
        }
        
        it("can store a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.CityState, value)
          
          let result = NSUserDefaults.standardUserDefaults().dictionaryForKey(identifier) as! [String: String]
          
          expect(result) == value
        }
        
        it("can store an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.LuckyNumber, value)
          
          let result = NSUserDefaults.standardUserDefaults().integerForKey(identifier)
          
          expect(result) == value
        }
        
        it("can store a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
          NSUserDefaults.standardUserDefaults().removeObjectForKey(identifier)
          
          Settings.set(.ApiEnvironment, value)
          
          let result = NSUserDefaults.standardUserDefaults().stringForKey(identifier)
          
          expect(result) == value
        }
        
      }
      
    }
    
    
    describe("get()") {
      
      context("when fetching any supported Settings.bundle preference item value type") {
        
        it("can fetch an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.SocialNetworks.get() as! [String]
          
          expect(result) == value
        }
        
        it("can fetch a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
          NSUserDefaults.standardUserDefaults().setBool(value, forKey: identifier)
          
          let result = Settings.EnableAnalytics.get() as! Bool
          
          expect(result) == value
        }
        
        it("can fetch data") {
          let identifier = Settings.EncodedString.identifier
          let value = NSData(base64EncodedString: "SGVsbG8gV29ybGQ=", options: []) as NSData!
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.EncodedString.get() as! NSData
          
          expect(result) == value
        }
        
        it("can fetch a date") {
          let identifier = Settings.DateOfBirth.identifier
          let formatter = NSDateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
          let value = formatter.dateFromString("1969-02-26") as NSDate!
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.DateOfBirth.get() as! NSDate
          
          expect(result) == value
        }
        
        it("can fetch a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.CityState.get() as! [ String: String ]
          
          expect(result) == value
        }
        
        it("can fetch an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
          NSUserDefaults.standardUserDefaults().setInteger(value, forKey: identifier)
          
          let result = Settings.LuckyNumber.get() as! Int
          
          expect(result) == value
        }
        
        it("can fetch a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.ApiEnvironment.get() as! String
          
          expect(result) == value
        }
        
      }
      
    }
    
    
    describe("get() — convenience method") {
      
      context("when fetching any supported Settings.bundle preference item value type") {
        
        it("can fetch an array") {
          let identifier = Settings.SocialNetworks.identifier
          let value = [ "facebook", "twitter", "instagram" ]
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.get(.SocialNetworks) as! [String]
          
          expect(result) == value
        }
        
        it("can fetch a bool") {
          let identifier = Settings.EnableAnalytics.identifier
          let value = true
          
          NSUserDefaults.standardUserDefaults().setBool(value, forKey: identifier)
          
          let result = Settings.get(.EnableAnalytics) as! Bool
          
          expect(result) == value
        }
        
        it("can fetch data") {
          let identifier = Settings.EncodedString.identifier
          let value = NSData(base64EncodedString: "SGVsbG8gV29ybGQ=", options: []) as NSData!
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.get(.EncodedString) as! NSData
          
          expect(result) == value
        }
        
        it("can fetch a date") {
          let identifier = Settings.DateOfBirth.identifier
          let formatter = NSDateFormatter()
          formatter.dateFormat = "yyyy-MM-dd";
          let value = formatter.dateFromString("1969-02-26") as NSDate!
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.get(.DateOfBirth) as! NSDate
          
          expect(result) == value
        }
        
        it("can fetch a dictionary") {
          let identifier = Settings.CityState.identifier
          let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.get(.CityState) as! [ String: String ]
          
          expect(result) == value
        }
        
        it("can fetch an integer") {
          let identifier = Settings.LuckyNumber.identifier
          let value = 23
          
          NSUserDefaults.standardUserDefaults().setInteger(value, forKey: identifier)
          
          let result = Settings.get(.LuckyNumber) as! Int
          
          expect(result) == value
        }
        
        it("can fetch a string") {
          let identifier = Settings.ApiEnvironment.identifier
          let value = "Staging"
          
          NSUserDefaults.standardUserDefaults().setObject(value, forKey: identifier)
          
          let result = Settings.get(.ApiEnvironment) as! String
          
          expect(result) == value
        }
        
      }
      
    }
    
    describe("subscribe()") {
      
      context("when the observed setting changes") {
        
        it("the onChange closure is called") {
          var handlerWasCalled = false
          
          NSUserDefaults.standardUserDefaults().setBool(false, forKey: Settings.EnableAnalytics.identifier)
          
          Settings.EnableAnalytics.subscribe { (newValue) -> Void in
            handlerWasCalled = true
          }
          
          NSUserDefaults.standardUserDefaults().setBool(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(handlerWasCalled).toEventually(beTrue())
        }
        
        it("the new value of the observed setting is passed to the onChange closure") {
          var result = false
          
          NSUserDefaults.standardUserDefaults().setBool(false, forKey: Settings.EnableAnalytics.identifier)
          
          Settings.EnableAnalytics.subscribe { (newValue) -> Void in
            if let newValue = newValue as? Bool {
              result = newValue
            }
          }
          
          NSUserDefaults.standardUserDefaults().setBool(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(result).toEventually(beTrue())
        }
      }
      
    }
    
    describe("subscribe() — convenience method") {
      
      context("when the observed setting changes") {
        
        it("the onChange closure is called") {
          var handlerWasCalled = false
          
          NSUserDefaults.standardUserDefaults().setBool(false, forKey: Settings.EnableAnalytics.identifier)
          
          Settings.subscribe(.EnableAnalytics) { (newValue) -> Void in
            handlerWasCalled = true
          }
          
          NSUserDefaults.standardUserDefaults().setBool(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(handlerWasCalled).toEventually(beTrue())
        }
        
        it("the new value of the observed setting is passed to the onChange closure") {
          var result = false
          
          NSUserDefaults.standardUserDefaults().setBool(false, forKey: Settings.EnableAnalytics.identifier)
          
          Settings.subscribe(.EnableAnalytics) { (newValue) -> Void in
            if let newValue = newValue as? Bool {
              result = newValue
            }
          }
          
          NSUserDefaults.standardUserDefaults().setBool(true, forKey: Settings.EnableAnalytics.identifier)
          
          expect(result).toEventually(beTrue())
        }
      }
      
    }
    
  }
}
