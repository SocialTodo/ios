//
//  TodoListEntity.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import Fluent

final class TodoListEntity: Entity {
    let storage = Storage()
    
    var title: String
    var shared: Bool
    var listOwnerId: Identifier
    var listOwner: Parent<TodoListEntity, FacebookUser> {
        return parent(id: listOwnerId)
    }
    var listItems: Children<TodoListEntity, TodoItemEntity> {
        return children()
    }
    
    enum Keys {
        static let title = "title"
        static let shared = "shared"
        static let listOwnerId = FacebookUser.foreignIdKey
    }
    
    init(title:String, listOwner: FacebookUser, shared: Bool) {
        self.title = title
        // Add error handling if the user hasn't been saved yet
        self.listOwnerId = listOwner.id!
        self.shared = shared
    }
    
    init(row: Row) throws {
        title = try row.get(Keys.title)
        listOwnerId = try row.get(Keys.listOwnerId)
        shared = try row.get(Keys.shared)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.title, title)
        try row.set(Keys.listOwnerId, listOwnerId)
        return row
    }
}

extension TodoListEntity: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) {
            $0.id()
            $0.bool(Keys.shared)
            $0.string(Keys.title)
            $0.string(Keys.listOwnerId)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension TodoListEntity: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("title", title)
        try node.set("list_id", id)
        try node.set("list_items", listItems)
        return node
    }
}

