//
//  BFCoreTeams.swift
//  buildflow-core: Collection of Teams
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreTeams : BFCoreBaseCollection, BFCoreCollectionProtocol {
    private var _collection = Array<BFCoreTeam>()
    
    // -------------------------------------------------------------------------
    // MARK: - Access (Use protocl implemetation later)
    
    var count: Int {
        get {
            return _collection.count
        }
    }

    // -------------------------------------------------------------------------

    var first: BFCoreTeam? {
        get {
            if _collection.count > 0 {
                return _collection.first
            }
            
            return nil
        }
    }

    // -------------------------------------------------------------------------

    func list() -> Array<BFCoreTeam> {
        return _collection
    }

    // -------------------------------------------------------------------------

    func add(_ team: BFCoreTeam) {
        _collection.append(team)
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Dump

    func dump() {
        for team in _collection {
            team.dump()
        }
    }

    // -------------------------------------------------------------------------

}

