//
//  RBNetwork.swift
//  buildflow-core: Base network stuff
//
//  Created by Roger Boesch on 03.10.17.
//  Copyright © 2017 Roger Boesch. All rights reserved.
//

import Foundation

enum BFCoreHTTPMethod {
    case GET, POST
}

class BFCoreNetwork {
    
    // -------------------------------------------------------------------------
    // MARK: - Request
    
    public func performRequest(method: BFCoreHTTPMethod = .GET, urlString: String, data: [String: Any]? = nil, header: [String: Any]? = nil) -> BFCoreResult {
        guard let url = URL(string: urlString) else {
            rbError("Cant create URL: \(urlString)")
            return BFCoreResult(error: .invalidArguments)
        }
        
        rbDebug("Calling url: %@", urlString)
        var request = URLRequest(url: url)
        
        switch method {
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
        }
        
        // Create request header
        var useJSON = false
        if header != nil  {
            for key in header!.keys {
                if let value = header![key] as? String {
                    request.addValue(value, forHTTPHeaderField: key)
                    
                    if key.lowercased() == "content-type" && value == "application/json" {
                        useJSON = true
                    }
                }
                else {
                    rbError("Invalid format for header field: %@", key)
                    
                    return BFCoreResult(error: .invalidArguments)
                }
            }
        }
        
        // Create request body
        if data != nil  {
            if useJSON {
                rbDebug("Use JSON body")

                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data!, options: JSONSerialization.WritingOptions())
                    request.httpBody = jsonData
                }
                catch _ {
                    rbError("Error set json to http-body: %@", data!)
                    return BFCoreResult(error: .invalidArguments)
                }
            }
            else {
                rbDebug("Use plain body")
                
                var query = ""
                for key in data!.keys {
                    if let value = data![key] as? String {
                        if query.count > 0 {
                            query = query + "&"
                        }
                        let entry = key + "=" + value
                        query = query + entry
                    }
                    else if let value = data![key] as? Int {
                        if query.count > 0 {
                            query = query + "&"
                        }
                        let entry = key + "=" + "\(value)"
                        query = query + entry
                    }
                }
                
                request.httpBody = query.data(using: .utf8)
            }
        }

        var itcResult = BFCoreResult()
        
        let session = URLSession.shared
        
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: request) { data, response, error in
            // Add http response
            itcResult = BFCoreResult(response: response)
            
            // Handle response
            if error != nil {
                itcResult.error = .unknown
            }
            else {
                // Parse data
                itcResult.error = .none
                
                if (data != nil) {
                    if let result = String(data: data!, encoding: .utf8) {
                        itcResult.result = result
                        
                        // Try json parsing
                        do {
                            itcResult.json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                        }
                        catch {
                            rbDebug("JSON parsing failed: %@", itcResult.result!)
                        }

                        itcResult = itcResult.parse()
                    }
                }
                else {
                    // Catch response
                }
            }
            
            // Signal finish
            semaphore.signal()
        }
        
        task.resume()
        
        let timeout = DispatchTime.now() + BFCore.Network.timeout
        _ = semaphore.wait(timeout: timeout)
        
        return itcResult
    }
    
    // -------------------------------------------------------------------------

}


