//
//  BFCoreUser.swift
//  buildflow-core: User
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreUser : BFCoreBaseEntity {
    private var _name = ""
    private var _fullName = ""
    private var _contentProviderId: Int = 0

    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var name: String {
        get {
            return _name
        }
        set(value) {
            _name = value
        }
    }

    // -------------------------------------------------------------------------
    
    var fullName: String {
        get {
            return _fullName
        }
        set(value) {
            _fullName = value
        }
    }

    // -------------------------------------------------------------------------
    
    var contentProviderId: Int {
        get {
            return _contentProviderId
        }
        set(value) {
            _contentProviderId = value
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Dump
    
    func dump() {
        let str = "User> \(self.name) (\(self.fullName))"
        rbDebug(str)
    }
    
    // -------------------------------------------------------------------------

}
