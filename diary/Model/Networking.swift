//
//  Networking.swift
//  diary
//
//  Created by Арман on 11/6/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation

class Networking {
    static func Request(for url: URL, _ type: String, completion: @escaping (Bool, Any?, Error?) -> Void) {
        var request = URLRequest(url: url)
        let type = type.uppercased()
        request.httpMethod = type
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    DispatchQueue.main.async {
                        completion(true, json, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, nil, error)
                    }
                }
            }
        }.resume()
    }
    
    
}
