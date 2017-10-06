//
//  BFCore.swift
//  buildflow-core: Constant definitions
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

struct BFCore {
    
    struct Version {
        static public let name = "buildcore"
        static public let major: Int = 0
        static public let minor: Int = 5

    }
    
    struct Keys {
        static public let user = "buildflow.user"
        static public let password = "buildflow.password"
    }
    
    struct Network {
        static public let protocolVersion = "QH65B2"
        static public let timeout = 60.0

        struct Url {

            struct Itc {
                static public let serviceKey = "https://olympus.itunes.apple.com/v1/app/config?hostname=itunesconnect.apple.com"
                static public let login = "https://idmsa.apple.com/appleauth/auth/signin"
                static public let olympusSession = "https://olympus.itunes.apple.com/v1/session"

                static public let session = "http://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/v1/session/webSession"
                static public let userDetails = "http://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/user/detail"
            }

            struct Portal {
                static public let service = "https://developer.apple.com/services-account/%@/"
            }
        }
        
        struct Action {
            
            struct Portal {
                 // ios and mac used dynamic later
                static public let appList = "account/ios/identifiers/listAppIds.action"
                static public let appDetail = "account/ios/identifiers/getAppIdDetail.action"

                static public let teamList = "account/listTeams.action"
                
                static public let teamMemberList = "account/getTeamMembers"
            }
            
        }
    }
}

