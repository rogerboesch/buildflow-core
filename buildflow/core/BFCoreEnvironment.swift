//
//  BFCoreEnvironment.swift
//  buildflow-core: (Basic) Process environment handling
//
//  Created by Roger Boesch on 04.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreEnvironment {
    private var _username: String?
    private var _password: String?

    // -------------------------------------------------------------------------
    // MARK: - Version Properties
    
    var version: Float {
        get {
            let str = self.versionText
            if let number = Float(str) {
                return number
            }
            
            return 0
        }
    }
    
    // -------------------------------------------------------------------------
    
    var versionText: String {
        get {
            let str = String(format: "%d.%d", BFCore.Version.major, BFCore.Version.minor)
            return str
        }
    }
    
    // -------------------------------------------------------------------------
    
    var versionName: String {
        get {
            let str = String(format: "%@ %@", BFCore.Version.name, self.versionText)
            return str
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Properties

    var username: String? {
        get {
            return _username
        }
    }

    // -------------------------------------------------------------------------

    var password: String? {
        get {
            return _password
        }
    }
   
    // -------------------------------------------------------------------------

    private func mapVariable(_ variable: String) -> String? {
        if let value = ProcessInfo.processInfo.environment[variable] {
            return value
        }

        return nil
    }

    // -------------------------------------------------------------------------

    private func mapVariables() {
        if let username = mapVariable(BFCore.Keys.user) {
            _username = username
        }
        if let password = mapVariable(BFCore.Keys.password) {
            _password = password
        }
    }

    // -------------------------------------------------------------------------

    static let shared: BFCoreEnvironment = {
        let instance = BFCoreEnvironment()
        instance.mapVariables()
        return instance
    }()

    
    // -------------------------------------------------------------------------

}
