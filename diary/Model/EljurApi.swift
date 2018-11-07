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
                guard let response = data as? [String:Any] else {return}
                guard let responseArray = response["response"] as? [String:Any] else {return}
                if let errorString = responseArray["error"] as? String , errorString != "<null>"{
                    print(errorString)
                    completion(nil, nil, errorString)
                } else {
                    guard let resultArray = responseArray["result"] as? [String:Any] else {return}
                    guard let tokenAuth = resultArray["token"] as? String else {return}
                    completion(tokenAuth, nil, nil)
                }
            } else if error != nil {
                print(error!)
                completion(nil, error, nil)
            }
        }
    }
    
    static func getSchedule(completion: @escaping ([String:Any]?, Error?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {return}
        guard let stringUrl = "https://api.eljur.ru/api/getschedule?class=11МИ4&devkey=\(devkey)&vendor=\(vendor)&rings=yes&out_format=json&auth_token=\(token)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {return}
        guard let url = URL(string: stringUrl) else {return}
        
        print(url)
        Networking.Request(for: url, "get") { (success, data, error) in
            if success {
                guard let response = data as? [String:Any] else {return}
                guard let responseArray = response["response"] as? [String:Any] else {return}
                guard let resultArray = responseArray["result"] as? [String:Any] else {return}
                guard let daysArray = resultArray["days"] as? [String:Any] else {return}
                completion(daysArray, nil)
            } else {
                print(error!)
                completion(nil, error)
            }
        }
    }
}
