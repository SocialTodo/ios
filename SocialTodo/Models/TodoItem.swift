//
//  TodoItem.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/3/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

struct TodoItem: Codable {
    var title: String
    var isChecked: Bool
    
    enum CodingKeys: String, CodingKey {
        case title
        case isChecked = "checked"
    }
}
