//
//  FriendTodoItem.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 3/3/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct FriendTodoItem: Codable {
    var id: Int?
    var title: String
    var isChecked: Bool
    var clapped: Bool
    var claps: Int
    var todoListId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case clapped
        case claps
        case isChecked = "checked"
        case todoListId = "todo_list_id"
    }
}
