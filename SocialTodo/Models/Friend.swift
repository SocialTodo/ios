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
    var name: String
    var todoLists: [TodoList]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case todoLists = "lists"
    }
}
