//
//  API.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class API {
    static let url = "http://localhost:8080/api"
    static let list = "\(API.url)/list"
    static let item = "\(API.url)/item"
    static let users = "\(API.url)/users"
    
    static func requestHeaders() -> [String: String]? {
        guard let accessToken = AccessToken.current else {
            return nil
        }
        let headers = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        return headers
    }
}
