//
//  User.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 3/3/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var facebookUserId: Int
    var name: String
    var claps: Int
    var friends: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case facebookUserId
        case name
        case claps
        case friends
    }
}
