//
//  BFCoreTeam.swift
//  buildflow-core: Team
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

enum BFCoreTeamType {
    case none, individual, copmpany, inHouse
}

class BFCoreTeam : BFCoreBaseEntity {
    private var _providerId: Int = 0
    private var _id = ""
    private var _name = ""
    private var _type = BFCoreTeamType.none
    
    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var providerId: Int {
        get {
            return _providerId
        }
        set(value) {
            _providerId = value
        }
    }
    
    // -------------------------------------------------------------------------
    
    var id: String {
        get {
            return _id
        }
        set(value) {
            _id = value
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
    
    var type: BFCoreTeamType {
        get {
            return _type
        }
        set(value) {
            _type = value
        }
    }

    // -------------------------------------------------------------------------

    func dump() {
        let str = "Team> \(self.id) (\(self.name), \(self.type))"
        rbDebug(str)
    }
    
    // -------------------------------------------------------------------------
}
