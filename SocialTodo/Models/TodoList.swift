//
//  TodoList.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/3/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct TodoList: Codable {
    var title: String
    var id: Int?
    var isShared: Bool
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case isShared = "shared"
    }
}
