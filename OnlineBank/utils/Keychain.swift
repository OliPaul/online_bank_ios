//
//  Keychain.swift
//  OnlineBank
//
//  Created by Paul Olivier on 26/06/2021.
//

import Foundation
import SwiftKeychainWrapper

class Keychain {
    
    public func store(key: String, value: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    public func store(key: String, value: Data) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    public func get(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    public func get(key: String) -> Data? {
        return KeychainWrapper.standard.data(forKey: key)
    }
}
