//
//  Friend.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/11/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct Friend: Codable {
    var id: Int
    var facebookUserId: Int
    var name: String
    var claps: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case facebookUserId
        case name
        case claps
    }
}
