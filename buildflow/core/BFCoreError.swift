//
//  BFCoreError.swift
//  buildflow-core: Error structs and handling
//
//  Each Apple API handles errors in a different way.
//  Goal of BFCoreError is to handle that as good as possible internally
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

enum BFCoreError {
    case none
    case noUser
    case noPassword
    case invalidArguments
    case serviceUnavailable
    case serviceFailed
    case invalidUserOrPassword
    case twoFactorAuthentificationNotSupported
    case mustSelectATeam
    case licenseUpdated
    case unknown
}

struct BFCoreResult {
    var success = true
    var error: BFCoreError = .none
    var httpStatus = 0
    var message: String?
    var code: Int?
    
    // Those two properties are not really needed after parsing but let it here
    // to make testing and debugging easier
    
    var result: String?         // Original response string
    var json: [String: Any]?    // JSON if response contains json

    // -------------------------------------------------------------------------
    // MARK: Initialisation
    
    init() {
    }

    // -------------------------------------------------------------------------

    init(error: BFCoreError) {
        self.error = error
        self.success = false
    }

    // -------------------------------------------------------------------------

    init(response: URLResponse?) {
        if let httpResponse = response as? HTTPURLResponse {
            self.httpStatus = httpResponse.statusCode
        }
        else {
            self.error = .unknown
            self.success = false
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Common error scenarios
    
    func parse() -> BFCoreResult {
        var result = self
        
        if result.result != nil {
            if self.httpStatus == 200 {
                result.error = .none
                result.success = true
            }
            else if self.result!.lowercased().range(of: "unavailable") != nil {
                result.error = .serviceUnavailable
                result.success = false
            }
            else if self.result!.lowercased().range(of: "http 405") != nil {
                result.error = .serviceFailed
                result.httpStatus = 405
                result.success = false
            }
        }
        
        // Parse json for common errors
        if let json = self.json {
            if let serviceError = json["serviceErrors"] as? Array<Dictionary<String, Any>> {
                let error = serviceError.first!
                if let message = error["message"] as? String, let code = error["code"] as? String {
                    result.success = false
                    result.error = .unknown
                    result.message = message
                    result.code = Int(code)
                }
            }

            // Program License Agreement updated
            if let resultString = json["resultString"] as? String {
                if resultString.contains("Program License Agreement updated") {
                    result.success = false
                    result.error = .licenseUpdated
                    result.message = resultString
                }
            }
        }
        
        return result
    }

    // -------------------------------------------------------------------------
    // MARK: - Log an error

    func log() {
        var str = "Error: "

        if self.error == .none {
            rbDebug("Success")
            return
        }
        else if self.error == .unknown {
            if self.message != nil {
                str = str + message!
            }
            if self.code != nil {
                str = str + " \(self.code!)"
            }

            rbWarning(str)

            return
        }
        
        str = str + "\(self.error)"
        str = str + ", HTTP Status: \(self.httpStatus)"
        
        if result != nil && json != nil {
            str = str + " (Result: YES, JSON: YES)"
        }
        else if result != nil {
            str = str + " (Result: YES, JSON: NO)"
        }
        else if json != nil {
            str = str + " (Result: NO, JSON: YES)"
        }

        rbWarning(str)
    }

    // -------------------------------------------------------------------------
    
}
