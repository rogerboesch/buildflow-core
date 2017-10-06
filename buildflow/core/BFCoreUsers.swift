//
//  BFCoreUsers.swift
//  buildflow-core: Collection of Users
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreUsers : BFCoreBaseCollection, BFCoreCollectionProtocol {
    private var _collection = Array<BFCoreUser>()
    
    // -------------------------------------------------------------------------
    // MARK: - Access (Use protocl implemetation later)
    
    var count: Int {
        get {
            return _collection.count
        }
    }

    // -------------------------------------------------------------------------
    
    var first: BFCoreUser? {
        get {
            if _collection.count > 0 {
                return _collection.first
            }
            
            return nil
        }
    }

    // -------------------------------------------------------------------------

    func list() -> Array<BFCoreUser> {
        return _collection
    }
 
    // -------------------------------------------------------------------------
    
    func add(_ user: BFCoreUser) {
        _collection.append(user)
    }

    // -------------------------------------------------------------------------
    // MARK: - Dump

    func dump() {
        for user in _collection {
           user.dump()
        }
    }

    // -------------------------------------------------------------------------

}
