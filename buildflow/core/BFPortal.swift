//
//  BFCorePortal.swift
//  buildflow-core: App portal access
//
//  Created by Roger Boesch on 02.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

class BFCorePortal {
    private var _connection: BFCoreConnect!
    private var _team = BFCoreTeam()
    private var _teams = BFCoreTeams()
    private var _users = BFCoreUsers()
    private var _apps = BFCoreApps()

     // Paging must be later made dynamic
    private var _pageSize = 100
    private var _pageCount = 1

    // -------------------------------------------------------------------------
    // MARK: - Properties

    var teams: BFCoreTeams {
        get {
            if _teams.asState == .notLoaded {
                // Retrieve now
                let result = self.performGetTeams()
                _teams.asState = result.success ? .loaded : .error
            }
            
            return _teams
        }
    }
    
    // -------------------------------------------------------------------------

    var users: BFCoreUsers {
        get {
            return _users
        }
    }
    
    // -------------------------------------------------------------------------

    var apps: BFCoreApps {
        get {
            if _apps.asState == .notLoaded {
                // Retrieve now
                let result = self.performGetApps()
                _apps.asState = result.success ? .loaded : .error
            }
            
            return _apps
        }
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Intrenal Properties

    private var serviceUrlString: String {
        get {
            let str = String(format: BFCore.Network.Url.Portal.service, BFCore.Network.protocolVersion)
            return str
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Network methods
    
    private func performRequest(action: String, data: [String: Any]? = nil, header: [String: Any]? = nil) -> BFCoreResult {
        let urlString = String(format: BFCore.Network.Url.Portal.service, BFCore.Network.protocolVersion) + action
        
        return _connection.performRequest(method: .POST, urlString: urlString, data: data, header: header)
    }
    
    // -------------------------------------------------------------------------
    // MARK: - App methods

    private func performGetApps() -> BFCoreResult {
        var result = performRequest(action: BFCore.Network.Action.Portal.appList,
                                    data: ["teamId":_team.id, "pageNumber":_pageCount, "pageSize": _pageSize, "sort":"name=asc"])
        
        if let resultCode = result.json?["resultCode"] as? Int {
            if resultCode == 3050 {
                result.error = .mustSelectATeam
                result.success = false
            }
        }
        
        result.log()

        if result.success {
            _apps.clear()
            
            if let appIds = result.json?["appIds"] as? Array<Dictionary<String, Any>> {
                for appId in appIds {
                    if let id = appId["appIdId"] as? String, let identifier = appId["identifier"] as? String, let name = appId["name"] as? String {
                        let app = BFCoreApp(id: id)
                        app.bundleId = identifier
                        app.name = name
                        app.asState = .partiallyLoaded
                        _apps.add(app)
                    }
                }
           }
        }
        
        return result
    }
    
    // -------------------------------------------------------------------------

    public func load(app: BFCoreApp) {
        let result = performRequest(action: BFCore.Network.Action.Portal.appDetail,
                                    data: ["teamId": _team.id, "appIdId": app.id])
        result.log()
        
        if result.success {
            app.apply(json: result.json)
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Team methods

    private func performGetTeams() -> BFCoreResult {
        let result = performRequest(action: BFCore.Network.Action.Portal.teamList)
        result.log()
        
        if let entries = result.json?["teams"] as? Array<Dictionary<String, Any>> {
            for entry in entries {
                if let id = entry["teamId"] as? String, let name = entry["name"] as? String, let type = entry["type"] as? String {
                    let team = BFCoreTeam()
                    team.id = id
                    team.name = name
                    
                    if type.lowercased() == "individual" {
                        team.type = .individual
                    }
                    else if type.lowercased() == "in-house" {
                        team.type = .inHouse
                    }
                    else if type.lowercased() == "company/organization" {
                        team.type = .copmpany
                    }
                    team.asState = .loaded
                    
                    _teams.add(team)
                }
            }
        }

        return result
    }

    // -------------------------------------------------------------------------

    public func selectTeam(_ team: BFCoreTeam) -> BFCoreResult {
        _team = team
        return _connection.selectTeam(id: team.id)
    }

    // -------------------------------------------------------------------------
    // MARK: - Team members
    
    private func performGetTeamMembers() -> BFCoreResult {
        let result = performRequest(action: BFCore.Network.Action.Portal.teamMemberList,
                                    data: ["teamId":_team.id], header: ["Content-Type":"application/json"])
        result.log()
        
        return result
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Initialisation

    init(connection: BFCoreConnect) {
        _connection = connection
    }

    // -------------------------------------------------------------------------

}
