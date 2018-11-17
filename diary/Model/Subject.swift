//
//  Subject.swift
//  diary
//
//  Created by Арман on 11/7/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation

struct Subject: Codable {
    var name: String
    var teacher: String
    var num: String
    var room: String
    var start: String
    var end: String
    var group: String?
    
    init(name: String, teacher: String, num: String, room: String, start: String, end: String, group: String?) {
        self.name = name
        self.teacher = teacher
        self.num = num
        self.room = room
        self.start = start
        self.end = end
        self.group = group
    }
}
