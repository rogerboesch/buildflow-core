//
//  BFCoreConnect.swift
//  buildflow-core: iTunesConnect access
//
//  Created by Roger Boesch on 02.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCoreConnect : BFCoreNetwork {
    private var _serviceKey = ""
    private var _cookie = ""
    private var _userDetails = Dictionary<String, Any>()
    private var _dsId = ""

    private var _user = BFCoreUser()
    private var _teams = Array<BFCoreTeam>()

    private var _portal: BFCorePortal?

    // -------------------------------------------------------------------------
    // MARK: - Properties
    
    var isValidSession: Bool {
        get {
            if _user.name.count > 0 {
                return true
            }
            
            return false
        }
    }
    
    // -------------------------------------------------------------------------
    
    var user: BFCoreUser {
        get {
            return _user
        }
    }
    
    // -------------------------------------------------------------------------
    
    var teams: Array<BFCoreTeam> {
        get {
            return _teams
        }
    }
    
    // -------------------------------------------------------------------------
    
    var portal: BFCorePortal {
        get {
            if _portal == nil {
                _portal = BFCorePortal(connection: self)
            }
            
            return _portal!
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Cookie handling
    
    private func dumpCookies(full: Bool) {
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                if full {
                    rbDebug("Cookie: \(cookie)")
                }
                else {
                    rbDebug("Cookie: \(cookie.name)")
                }
            }
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Internal (Dont use those methods directly)

    func selectTeam(id: String) -> BFCoreResult {
        rbDebug("Calling method: %@", "selectTeam() with \(id)")

        if _dsId.count == 0 {
            return BFCoreResult(error: .invalidArguments)
        }
        
        let result = performRequest(method: .POST, urlString: BFCore.Network.Url.Itc.session, data: ["contentProviderId": id, "dsId": _dsId], header:["Content-Type":"application/json"])
        result.log()
        
        return result
    }

    // -------------------------------------------------------------------------

    private func mapTeams() {
        rbDebug("Calling method: %@", "getTeams()")

        if let accounts = _userDetails["associatedAccounts"] as? Array<Dictionary<String, Any>> {
            for entry in accounts {
                if let provider = entry["contentProvider"] as? Dictionary<String, Any> {
                    if let name = provider["name"] as? String, let providerId = provider["contentProviderId"] as? Int {
                        let team = BFCoreTeam()
                        team.name = name
                        team.providerId = providerId
                        
                        _teams.append(team)
                    }
                }
            }
        }
    }
    // -------------------------------------------------------------------------

    private func mapUserDetails() {
        rbDebug("Calling method: %@", "mapUserDetails()")

        if let token = _userDetails["sessionToken"] as? Dictionary<String, Any> {
            if let dsId = token["dsId"] as? String {
                _dsId = dsId
            }
            else {
                rbWarning("DsId not found in sessionToken")
            }
            
            if let contentProviderId = token["contentProviderId"] as? Int {
                _user.contentProviderId = contentProviderId
            }
            else {
                rbWarning("contentProviderId not found in sessionToken")
            }
        }
        
        // Mapping of many associatedAccounts must be done
        // mapTeams()
    }

    // -------------------------------------------------------------------------
    
    private func getUserDetails() {
        rbDebug("Calling method: %@", "getUserDetails()")

        let result = performRequest(method: .GET, urlString: BFCore.Network.Url.Itc.userDetails)
        result.log()
        
        if let user = result.json?["data"] as? Dictionary<String, Any> {
            _userDetails = user
            rbDebug("User details fetched")

            mapUserDetails()
        }
    }

    // -------------------------------------------------------------------------

    private func getServiceKey() {
        rbDebug("Calling method: %@", "getServiceKey()")
        
        if _serviceKey.count > 0 {
            return
        }
        
        let result = performRequest(method: .GET, urlString: BFCore.Network.Url.Itc.serviceKey)
        result.log()

        if let serviceKey = result.json?["authServiceKey"] as? String {
            _serviceKey = serviceKey

            rbDebug("Service key is: %@", _serviceKey)
        }
        else {
            rbError("Can't retrieve service key")
        }
    }

    // -------------------------------------------------------------------------

    private func getOlympusSession() {
        rbDebug("Calling method: %@", "getOlympusSession()")

        let result = performRequest(urlString: BFCore.Network.Url.Itc.olympusSession)
        result.log()
        
        if let user = result.json?["user"] as? Dictionary<String, Any> {
            if let email = user["emailAddress"] as? String {
                _user.name = email
            }
            if let name = user["fullName"] as? String {
                _user.fullName = name
            }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Login

    private func performLogin(user: String, password: String, trial: Int) -> BFCoreResult {
        rbDebug("Trial \(trial): Calling method: %@", "performLogin()")
        
        // Update service key
        getServiceKey()
        
        // Do the login
        let data = ["accountName": user, "password": password, "rememberMe": "true"]
        let header = ["Content-Type": "application/json", "X-Requested-With": "XMLHttpRequest", "X-Apple-Widget-Key": _serviceKey, "Accept": "application/json, text/javascript", "Cookie": ""]
        
        var result = performRequest(method: .POST, urlString: BFCore.Network.Url.Itc.login, data: data, header: header)
        
        if result.httpStatus == 200 {
            getOlympusSession()
            
            getUserDetails()
        }
        else if result.httpStatus == 403 {
            result.error = .invalidUserOrPassword
        }
        else if result.httpStatus == 409 {
            result.error = .twoFactorAuthentificationNotSupported
        }

        return result
    }

    // -------------------------------------------------------------------------
    // TODO: Load PW from ENV, if not set try get from keychain (otherwise password be set here)

    func login(user: String? = nil, password: String? = nil, trials: Int = 3) -> BFCoreResult {
        rbDebug("Calling method: %@", "login()")

        var user = user
        if user == nil {
            // Get user from ENV
            if let value = BFCoreEnvironment.shared.username {
                user = value
            }
            else {
                return BFCoreResult(error: .noUser)
            }
        }
        
        var password = password
        if password == nil {
            // Get password from ENV
            if let value = BFCoreEnvironment.shared.password {
                password = value
            }
            
            // Try get password from keychain
            if password == nil {
                password = BFCoreKeychain.shared.loadPassword()
            }
            
            if password == nil {
                return BFCoreResult(error: .noPassword)
            }
        }

        var result = BFCoreResult()
        
        for trial in 1...trials {
            result = performLogin(user: user!, password: password!, trial: trial)
            
            if result.error != .serviceUnavailable {
                return result
            }
        }
        
        return result
    }

    // -------------------------------------------------------------------------
}
