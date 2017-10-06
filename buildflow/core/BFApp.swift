//
//  BFCoreApp.swift
//  buildflow-core: App
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreApp : BFCoreBaseEntity {
    private var _id = ""
    private var _bundleId = ""
    private var _name = ""

    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var id: String {
        get {
            return _id
        }
    }
    
    // -------------------------------------------------------------------------
    
    var bundleId: String {
        get {
            return _bundleId
        }
        set(value) {
            _bundleId = value
        }
    }
    
    // -------------------------------------------------------------------------

    var name: String {
        get {
            return _name
        }
        set(value) {
            _name = value
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Dump

    func dump() {
        let str = "App> \(self.id) (\(self.bundleId), Name: \(self.name))"
        rbDebug(str)
    }
 
    // -------------------------------------------------------------------------
    // MARK: - Initialisation
    
    init(id: String) {
        _id = id
    }

}
