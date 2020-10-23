//
//  SettingsService.swift
//  
//
//  Created by Maksim Kirko on 10/23/20.
//

import Foundation

public protocol SettingsService {
    func getCity() -> String?
    func setCity(_ city: String?)
}

public class UserDefaultsWrapper<T> {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func getValue(for key: String) -> T? {
        return userDefaults.value(forKey: key) as? T
    }
    
    func setValue(_ t: T?, for key: String) {
        userDefaults.set(t, forKey: key)
    }
}

public class DefaultSettingsService: SettingsService {
    private struct Keys {
        static let cityKey = "City"
    }
    
    private let wrapper: UserDefaultsWrapper<String>
    
    public init() {
        self.wrapper = UserDefaultsWrapper(userDefaults: UserDefaults.standard)
    }
    
    public func getCity() -> String? {
        return self.wrapper.getValue(for: Keys.cityKey)
    }
    
    public func setCity(_ city: String?) {
        self.wrapper.setValue(city, for: Keys.cityKey)
    }
}
