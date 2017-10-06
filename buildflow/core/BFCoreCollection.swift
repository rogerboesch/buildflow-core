//
//  BFCoreCollection.swift
//  buildflow-core: Base collection (Placeholders at the moment)
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

enum BFCoreCollectionState {
    case notLoaded, loaded, partiallyLoaded, error
}

protocol BFCoreCollectionProtocol {
    var count: Int {get }
}

class BFCoreBaseCollection {
    private var _state = BFCoreCollectionState.notLoaded

    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var asState: BFCoreCollectionState {
        get {
            return _state
        }
        set(value) {
            _state = value
        }
    }
    
    // -------------------------------------------------------------------------
    
}

class BFCoreBaseEntity {
    private var _state = BFCoreCollectionState.notLoaded
    private var _json: Dictionary<String, Any>?

    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var asState: BFCoreCollectionState {
        get {
            return _state
        }
        set(value) {
            _state = value
        }
    }
    
    // -------------------------------------------------------------------------
    
    func apply(json: Dictionary<String, Any>?) {
        if json != nil {
            _state = .loaded
        }
        
        _json = json
    }
    
    // -------------------------------------------------------------------------
    
    func value(for key: String) -> String {
        if let value = _json?[key] as? String {
            return value
        }
        
        return ""
    }
    
    // -------------------------------------------------------------------------
    
    func intValue(for key: String) -> Int {
        if let value = _json?[key] as? Int {
            return value
        }
        
        return 0
    }

    // -------------------------------------------------------------------------
}

