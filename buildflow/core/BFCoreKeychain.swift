//
//  BFCoreKeychain.swift
//  buildflow-core: Keychain access
//
//  Created by Roger Boesch on 04.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation
import Security

public class BFCoreKeychain : BFCoreKeychainBase {

    // -------------------------------------------------------------------------

    func savePassword(_ password: String) -> Bool {
        return super.set(password, forKey: BFCore.Keys.password)
    }
    
    // -------------------------------------------------------------------------
    
    func loadPassword() -> String? {
        return super.get(BFCore.Keys.password)
    }
    
    // -------------------------------------------------------------------------
    
    func clearPassword() -> Bool {
        return super.delete(BFCore.Keys.password)
    }

    // -------------------------------------------------------------------------

    override init() {
        super.init()
    }

    // -------------------------------------------------------------------------

    static let shared: BFCoreKeychain = {
        let instance = BFCoreKeychain()
        return instance
    }()
    
    // -------------------------------------------------------------------------

}

public class BFCoreKeychainBase {
    private var _synchronizable = false
    private var _resultCode: OSStatus = noErr
    private var _accessGroup: String?

    // -------------------------------------------------------------------------

    @discardableResult
    func set(_ value: String, forKey key: String, withAccess access: BFCoreKeychainOptions? = nil) -> Bool {
        if let value = value.data(using: String.Encoding.utf8) {
            return set(value, forKey: key, withAccess: access)
        }
        
        return false
    }

    // -------------------------------------------------------------------------

    @discardableResult
    func set(_ value: Data, forKey key: String, withAccess access: BFCoreKeychainOptions? = nil) -> Bool {
        delete(key)
        
        let accessible = access?.value ?? BFCoreKeychainOptions.defaultOption.value
        
        var query: [String : Any] = [
            BFCoreKeychainConstants.klass       : kSecClassGenericPassword,
            BFCoreKeychainConstants.attrAccount : key,
            BFCoreKeychainConstants.valueData   : value,
            BFCoreKeychainConstants.accessible  : accessible
        ]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: true)
        
        _resultCode = SecItemAdd(query as CFDictionary, nil)
        
        return _resultCode == noErr
    }

    // -------------------------------------------------------------------------

    @discardableResult
    func set(_ value: Bool, forKey key: String, withAccess access: BFCoreKeychainOptions? = nil) -> Bool {
        let bytes: [UInt8] = value ? [1] : [0]
        let data = Data(bytes: bytes)
        
        return set(data, forKey: key, withAccess: access)
    }

    // -------------------------------------------------------------------------

    func get(_ key: String) -> String? {
        if let data = getData(key) {
            if let currentString = String(data: data, encoding: .utf8) {
                return currentString
            }
            
            _resultCode = -67853
        }
        
        return nil
    }

    // -------------------------------------------------------------------------

    func getData(_ key: String) -> Data? {
        var query: [String: Any] = [
            BFCoreKeychainConstants.klass       : kSecClassGenericPassword,
            BFCoreKeychainConstants.attrAccount : key,
            BFCoreKeychainConstants.returnData  : kCFBooleanTrue,
            BFCoreKeychainConstants.matchLimit  : kSecMatchLimitOne
        ]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        
        var result: AnyObject?
        
        _resultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if _resultCode == noErr {
            return result as? Data
        }
        
        return nil
    }

    // -------------------------------------------------------------------------

    func getBool(_ key: String) -> Bool? {
        guard let data = getData(key) else { return nil }
        guard let firstBit = data.first else { return nil }
        
        return firstBit == 1
    }

    // -------------------------------------------------------------------------

    @discardableResult
    func delete(_ key: String) -> Bool {
        var query: [String: Any] = [BFCoreKeychainConstants.klass: kSecClassGenericPassword,
                                    BFCoreKeychainConstants.attrAccount : key]
        
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        
        _resultCode = SecItemDelete(query as CFDictionary)
        
        return _resultCode == noErr
    }

    // -------------------------------------------------------------------------

    @discardableResult
    func clear() -> Bool {
        var query: [String: Any] = [ kSecClass as String : kSecClassGenericPassword ]
        query = addAccessGroupWhenPresent(query)
        query = addSynchronizableIfRequired(query, addingItems: false)
        
        _resultCode = SecItemDelete(query as CFDictionary)
        
        return _resultCode == noErr
    }

    // -------------------------------------------------------------------------

    func addAccessGroupWhenPresent(_ items: [String: Any]) -> [String: Any] {
        guard let accessGroup = _accessGroup else { return items }
        
        var result: [String: Any] = items
        result[BFCoreKeychainConstants.accessGroup] = accessGroup
        
        return result
    }

    // -------------------------------------------------------------------------

    func addSynchronizableIfRequired(_ items: [String: Any], addingItems: Bool) -> [String: Any] {
        if !_synchronizable {
            return items
        }
        
        var result: [String: Any] = items
        result[BFCoreKeychainConstants.attrSynchronizable] = addingItems == true ? true : kSecAttrSynchronizableAny
        return result
    }

    // -------------------------------------------------------------------------

}

public struct BFCoreKeychainConstants {
    public static var attrAccount: String { return toString(kSecAttrAccount) }
    public static var attrSynchronizable: String { return toString(kSecAttrSynchronizable) }
    public static var accessGroup: String { return toString(kSecAttrAccessGroup) }
    public static var accessible: String { return toString(kSecAttrAccessible) }
    public static var klass: String { return toString(kSecClass) }
    public static var matchLimit: String { return toString(kSecMatchLimit) }
    public static var valueData: String { return toString(kSecValueData) }
    public static var returnData: String { return toString(kSecReturnData) }
    
    static func toString(_ value: CFString) -> String {
        return value as String
    }
}

public enum BFCoreKeychainOptions {
    case accessibleWhenUnlocked
    case accessibleWhenUnlockedThisDeviceOnly
    case accessibleAfterFirstUnlock
    case accessibleAfterFirstUnlockThisDeviceOnly
    case accessibleAlways
    case accessibleWhenPasscodeSetThisDeviceOnly
    case accessibleAlwaysThisDeviceOnly
    
    static var defaultOption: BFCoreKeychainOptions {
        return .accessibleWhenUnlocked
    }
    
    var value: String {
        switch self {
        case .accessibleWhenUnlocked:
            return toString(kSecAttrAccessibleWhenUnlocked)
        case .accessibleWhenUnlockedThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
        case .accessibleAfterFirstUnlock:
            return toString(kSecAttrAccessibleAfterFirstUnlock)
        case .accessibleAfterFirstUnlockThisDeviceOnly:
            return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
        case .accessibleAlways:
            return toString(kSecAttrAccessibleAlways)
        case .accessibleWhenPasscodeSetThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
        case .accessibleAlwaysThisDeviceOnly:
            return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }
    
    func toString(_ value: CFString) -> String {
        return BFCoreKeychainConstants.toString(value)
    }
}
