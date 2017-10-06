//
//  BFCoreApps.swift
//  buildflow-core: Collection of Apps
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreApps : BFCoreBaseCollection, BFCoreCollectionProtocol {
    private var _collection = Array<BFCoreApp>()

    // -------------------------------------------------------------------------
    // MARK: - Access (Use protocl implemetation later)
    
    var count: Int {
        get {
            return _collection.count
        }
    }

    // -------------------------------------------------------------------------
    
    var first: BFCoreApp? {
        get {
            if _collection.count > 0 {
                return _collection.first
            }
            
            return nil
        }
    }

    // -------------------------------------------------------------------------
    
    func list() -> Array<BFCoreApp> {
        return _collection
    }

    // -------------------------------------------------------------------------
    
    func clear() {
         _collection.removeAll()
        self.asState = .notLoaded
    }

    // -------------------------------------------------------------------------
    
    func add(_ app: BFCoreApp) {
        _collection.append(app)
    }

    // -------------------------------------------------------------------------

    func find(Id: String) -> BFCoreApp? {
        return first
    }

    // -------------------------------------------------------------------------
    // MARK: - Dump

    func dump() {
        for app in _collection {
            app.dump()
        }
    }

    // -------------------------------------------------------------------------

}
