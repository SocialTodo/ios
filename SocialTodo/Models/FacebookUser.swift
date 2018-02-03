//
//  FacebookUser.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/28/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import Fluent

final class FacebookUser: Entity {
    //Fluent uses the storage to put fluent specific things onto it
    let storage = Storage()
    
    //Set up fields
    var name: String
    var facebookUserId: Int
    var facebookToken: String
    var facebookFriends: Siblings<FacebookUser, FacebookUser, Pivot<FacebookUser,FacebookUser>> {
        return siblings()
    }
    var todoLists: Children<FacebookUser, TodoListEntity> {
        return children()
    }
    
    struct Keys {
        static let name = "name"
        static let facebookUserId = "facebookUserId"
        static let facebookToken = "facebookToken"
    }
    
    init(userId facebookUserId:Int, token facebookToken:String, name:String){
        self.name = name
        self.facebookUserId = facebookUserId
        self.facebookToken = facebookToken
    }
    
    init(row: Row) throws {
        name = try row.get(Keys.name)
        facebookUserId = try row.get(Keys.facebookUserId)
        facebookToken = try row.get(Keys.facebookToken)
    }
    
    func setFriends(friends friendFacebookUsers:[FacebookUser]) throws {
        // This is a temporary workaround; deletes all the models then re-adds the ones passed.
        try facebookFriends.delete()
        try friendFacebookUsers.forEach{ try facebookFriends.add($0) }
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Keys.name, name)
        try row.set(Keys.facebookUserId, facebookUserId)
        try row.set(Keys.facebookToken, facebookToken)
        return row
    }
    
}

extension FacebookUser: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) {
            $0.id()
            $0.int(Keys.facebookUserId, unique: true)
            $0.string(Keys.facebookToken)
            $0.string(Keys.name)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension FacebookUser: NodeRepresentable {
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("user_id", facebookUserId)
        try node.set("lists", todoLists)
        return node
    }
}

