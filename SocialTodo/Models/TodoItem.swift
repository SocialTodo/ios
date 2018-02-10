//
//  TodoItem.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/3/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct TodoItem: Codable {
    var id: Int?
    var title: String
    var isChecked: Bool
    var todoListId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isChecked = "checked"
        case todoListId = "todo_list_id"
    }
}
