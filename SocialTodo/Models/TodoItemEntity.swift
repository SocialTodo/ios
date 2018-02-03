//
//  TodoItem.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import Fluent

final class TodoItemEntity: Entity {
    let storage = Storage()
    
    var title: String
    var checked: Bool
    private var parentListId: Identifier
    var parentList: Parent<TodoItemEntity, TodoListEntity> {
        return parent(id: parentListId)
    }
    
    enum Keys {
        static let title = "title"
        static let checked = "checked"
        static let parentListId = TodoListEntity.foreignIdKey
    }
    
    init(title:String, checked:Bool = false, parentList: TodoListEntity) {
        self.title = title
        self.checked = checked
        self.parentListId = parentList.id!
    }
    
    init(row: Row) throws {
        title = try row.get(Keys.title)
        checked = try row.get(Keys.checked)
        parentListId = try row.get(TodoListEntity.foreignIdKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.title, title)
        try row.set(Keys.checked, checked)
        try row.set(TodoListEntity.foreignIdKey, parentListId)
        return row
    }
}

extension TodoItemEntity: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) {
            $0.id()
            $0.string(Keys.title)
            $0.bool(Keys.checked)
            $0.parent(TodoListEntity.self)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension TodoItemEntity: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("title", title)
        try node.set("checked", checked)
        return node
    }
}
