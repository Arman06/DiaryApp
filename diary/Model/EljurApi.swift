//
//  EljurApi.swift
//  diary
//
//  Created by Арман on 11/7/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation

class Eljur {
    static func logIn(_ login: String, _ password: String, completion: @escaping (String?, Error?, String?) -> Void ) {
        guard let url = URL(string: "https://api.eljur.ru/api/auth?login=\(login)&password=\(password)&devkey=\(devkey)&vendor=\(vendor)&out_format=json"), login != "", password != "" else {return}
        Networking.Request(for: url, "post") { (success, data, error) in
            if success {
                if data?["response"]?["error"]?.string != nil {
                    completion(nil, nil, data?["response"]?["error"]?.string)
                } else {
                    completion(data!["response"]?["result"]?["token"]?.string, nil, nil)
                }
            } else if error != nil {
                print(error!)
                completion(nil, error, nil)
            }
        }
    }
    
    static func getSchedule(completion: @escaping (SuperJSON?, Error?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
        guard let stringUrl = "https://api.eljur.ru/api/getschedule?class=11МИ4&devkey=\(devkey)&vendor=\(vendor)&rings=yes&out_format=json&auth_token=\(token)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {return}
        guard let url = URL(string: stringUrl) else {return}
        print(url)
        Networking.Request(for: url, "get") { (success, data, error) in
            if success {
                completion(data!["response"]!["result"]!["days"], nil)
            } else {
                print(error!)
                completion(nil, error)
            }
        }
    }
}
