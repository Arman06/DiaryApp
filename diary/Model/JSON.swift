//
//  JSON.swift
//  diary
//
//  Created by Арман on 11/14/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation


struct SuperJSON {
    
    var count: Int? {
        switch type {
        case .array:
            guard let arrayFromData:[Any] = nedeedData() else {return nil}
            return arrayFromData.count
        case .single:
            return nil
        }
    }
    
    
    private var type: SuperJSONType = .single
    
    private func checkType() -> SuperJSONType {
        guard let _:[Any] = nedeedData() else {return .single}
        return .array
    }
    
    var string: String? {
        guard let stringFromData = data as? String else {return nil}
        return stringFromData
    }

    func nedeedData<T>() -> T? {
        guard let arrayFromData = data as? T else {return nil}
        return arrayFromData
    }
    
    var arrayJSON: [SuperJSON]? {
        guard let arrayFromData:[Any] = nedeedData() else {return nil}
        var jsonArray = [SuperJSON]()
        for index in arrayFromData.indices {
            jsonArray.append(SuperJSON(data: arrayFromData[index]))
        }
        return jsonArray
    }
    
    var array: [Any]? {
        guard let arrayFromData:[Any] = nedeedData() else {return nil}
        return arrayFromData
    }
    
    var dictionaryJSON: [String:SuperJSON]? {
        guard let arrayFromData:[String:Any] = nedeedData() else {return nil}
        var jsonArray = [String:SuperJSON]()
        for key in arrayFromData.keys {
            jsonArray[key] = (SuperJSON(data: arrayFromData[key]!))
        }
        return jsonArray
    }
    
    var dictionaryAny: [String:Any]? {
        guard let arrayFromData:[String:Any] = nedeedData() else {return nil}
        var jsonArray = [String:Any]()
        for key in arrayFromData.keys {
            jsonArray[key] = arrayFromData[key]
        }
        return jsonArray
    }
    
    
    private var data: Any?
    
    subscript(index: String) -> SuperJSON? {
        guard let sendData = data as? [String:Any] else {return nil}
        return SuperJSON(data: sendData[index]!)
    }
    
    subscript(index: Int) -> SuperJSON? {
        guard let arrayFromData:[Any] = nedeedData() else {return nil}
        return SuperJSON(data: arrayFromData[index])
    }
    
    init(data dataObj: Data, options opt: JSONSerialization.ReadingOptions = []) throws {
        let object: Any = try JSONSerialization.jsonObject(with: dataObj, options: opt)
        self.init(jsonData: object)
    }
    
    init(_ data: Any) {
        guard let initData = data as? Data else {
            self.init(jsonData: nil)
            return
        }
        do {
            try self.init(data: initData)
        } catch {
            print(error)
            self.init(jsonData: nil)
        }
    }
    
    private init(jsonData: Any?) {
        self.data = jsonData
        self.type = checkType()
    }
    
    private init(data: Any) {
        self.data = data
        self.type = self.checkType()
    }
    
    private init(data: Any, kind: SuperJSONType) {
        self.data = data
        self.type = kind
    }
    
}

extension SuperJSON {
    
    enum SuperJSONType {
        case array, single
    }
    
}

extension SuperJSON: CustomStringConvertible {
    
    var description: String {
        guard let message = data else {
            return "No such value"
        }
        return  String(describing: message)
    }
    
}
