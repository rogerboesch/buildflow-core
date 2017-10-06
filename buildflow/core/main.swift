//
//  main.swift
//  First simple example command line tool thats shows some classes and methods
//  available in buildflow-core. More will follow.
//
//  Created by Roger Boesch on 02.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

RBLog.severity = .debug

rbConsole("\(BFCoreEnvironment.shared.versionName) started.")

// Save password in keychain
if let pwd = BFCoreEnvironment.shared.password {
    if BFCoreKeychain.shared.savePassword(pwd) {
        rbConsole("Password saved in keychain.")
    }
}

// Connect
let connect = BFCoreConnect()
let result = connect.login()

if connect.isValidSession {
    let user = connect.user
    rbInfo("Logged in as user %@", user.fullName)

    // Show available teams
    let teams = connect.portal.teams
    rbInfo("%d team(s) found.", teams.count)

    if let team = teams.first {
        rbInfo("Select first team -> (%@)", team.name)
        _ = connect.portal.selectTeam(team)
    }
    
    // Show available apps
    let apps = connect.portal.apps
    rbInfo("%d application(s) found.", apps.count)

    if let app = apps.first {
        rbInfo("Select first app -> (%@)", app.name)

        _ = connect.portal.load(app: app)
        rbInfo("Details loaded for app (%@)", app.name)
   }
}
else {
    rbConsole("Login failed.")
    result.log()
}
