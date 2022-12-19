//
//  ConfigEnvironment.swift
//  DENTGigastoreSDK example
//
//  Created by Christian Trümper on 26.05.21.
//

import Foundation

public enum ConfigEnvironment
{
    enum ConfigKey: String {
        case versionControlRevision = "TDSVersionControlRevision"
        case bundleIdentifierKey = "CFBundleIdentifier"
        case bundleShortVersionString = "CFBundleShortVersionString"
        case bundleVersion = "CFBundleVersion"
    }
    
    private static let infoDictionary: [String: Any] = {
        
      guard let dict = Bundle.main.infoDictionary else {
        fatalError("Plist file not found")
      }
        
      return dict
    }()
    
    static func getConfig(key: ConfigKey) -> String {
        
        guard let value = ConfigEnvironment.infoDictionary[key.rawValue] as? String else {
            print("Config value not found: \(key.rawValue)")
            
            return ""
        }
        
        return value
    }
}
