//
//  SettingsKitTests.swift
//  SettingsKit
//
//  Created by Dan Trenz on 9/11/16.
//  Copyright © 2016 Dan Trenz. All rights reserved.
//

import XCTest

@testable import SettingsKit


enum Settings: SettingsKit {
    case apiEnvironment, cityState, dateOfBirth, enableAnalytics, encodedString, luckyNumber, socialNetworks
    
    var identifier: String {
        switch self {
        case .apiEnvironment:
            return "api_environment"
        case .cityState:
            return "city_state"
        case .dateOfBirth:
            return "date_of_birth"
        case .enableAnalytics:
            return "enable_analytics"
        case .encodedString:
            return "encoded_string"
        case .luckyNumber:
            return "lucky_number"
        case .socialNetworks:
            return "social_networks"
        }
    }
}


class SettingsKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDescription() {
        Settings.set(.luckyNumber, 23)
        XCTAssertEqual(Settings.luckyNumber.description, "23")
    }
    
    func testSetArray() {
        let identifier = Settings.socialNetworks.identifier
        let value = [ "facebook", "twitter", "instagram" ]
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.socialNetworks, value)
        
        let result = UserDefaults.standard.array(forKey: identifier) as! [String]
        
        XCTAssertEqual(result, value)
    }
    
    func testSetBool() {
        let identifier = Settings.enableAnalytics.identifier
        let value = true
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.enableAnalytics, value)
        
        let result = UserDefaults.standard.bool(forKey: identifier)
        
        XCTAssertEqual(result, value)
    }
    
    func testSetData() {
        let identifier = Settings.encodedString.identifier
        let value = NSData(base64Encoded: "SGVsbG8gV29ybGQ=", options: [])!
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.encodedString, value)
        
        let result = UserDefaults.standard.object(forKey: identifier) as! NSData
        
        XCTAssertEqual(result, value)
    }
    
    func testSetDate() {
        let identifier = Settings.dateOfBirth.identifier
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd";
        let value = formatter.date(from: "1969-02-26")!
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.dateOfBirth, value)
        
        let result = UserDefaults.standard.object(forKey: identifier) as! Date
        
        XCTAssertEqual(result, value)
    }
    
    func testSetDictionary() {
        let identifier = Settings.cityState.identifier
        let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.cityState, value)
        
        let result = UserDefaults.standard.dictionary(forKey: identifier) as! [String: String]
        
        XCTAssertEqual(result, value)
    }
    
    func testSetInt() {
        let identifier = Settings.luckyNumber.identifier
        let value = 23
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.luckyNumber, value)
        
        let result = UserDefaults.standard.integer(forKey: identifier)
        
        XCTAssertEqual(result, value)
    }
    
    func testSetString() {
        let identifier = Settings.apiEnvironment.identifier
        let value = "Staging"
        
        UserDefaults.standard.removeObject(forKey: identifier)
        
        Settings.set(.apiEnvironment, value)
        
        let result = UserDefaults.standard.string(forKey: identifier)
        
        XCTAssertEqual(result, value)
    }
    
    func testGetArray() {
        let identifier = Settings.socialNetworks.identifier
        let value = [ "facebook", "twitter", "instagram" ]
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.socialNetworks) as! [String]
        
        XCTAssertEqual(result, value)
    }
    
    func testGetBool() {
        let identifier = Settings.enableAnalytics.identifier
        let value = true
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.enableAnalytics) as! Bool
        
        XCTAssertEqual(result, value)
    }
    
    func testGetData() {
        let identifier = Settings.encodedString.identifier
        let value = NSData(base64Encoded: "SGVsbG8gV29ybGQ=", options: []) as NSData!
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.encodedString) as! NSData
        
        XCTAssertEqual(result, value)
    }
    
    func testGetDate() {
        let identifier = Settings.dateOfBirth.identifier
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd";
        let value = formatter.date(from: "1969-02-26")!
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.dateOfBirth) as! Date
        
        XCTAssertEqual(result, value)
    }
    
    func testGetDictionary() {
        let identifier = Settings.cityState.identifier
        let value = [ "Detroit": "Michigan", "Austin": "Texas", "Chicago": "Illinois" ]
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.cityState) as! [ String: String ]
        
        XCTAssertEqual(result, value)
    }
    
    func testGetInt() {
        let identifier = Settings.luckyNumber.identifier
        let value = 23
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.luckyNumber) as! Int
        
        XCTAssertEqual(result, value)
    }
    
    func testGetString() {
        let identifier = Settings.apiEnvironment.identifier
        let value = "Staging"
        
        UserDefaults.standard.set(value, forKey: identifier)
        
        let result = Settings.get(.apiEnvironment) as! String
        
        XCTAssertEqual(result, value)
    }
    
    func testSubscribe() {
        var result = false
        
        UserDefaults.standard.set(false, forKey: Settings.enableAnalytics.identifier)
        
        let expect = expectation(description: "onChange")
        
        Settings.subscribe(.enableAnalytics) { (newValue) -> Void in
            if let newValue = newValue as? Bool {
                result = newValue
            }
            
            expect.fulfill()
        }
        
        UserDefaults.standard.set(true, forKey: Settings.enableAnalytics.identifier)
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            XCTAssertEqual(result, true)
        }
    }
    
}
