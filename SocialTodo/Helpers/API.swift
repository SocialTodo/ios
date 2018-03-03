//
//  API.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/7/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class API {
    static let url = "https://socialtodo.net/api"
    static let me = "\(API.url)/me"
    static let list = "\(API.url)/list"
    static let item = "\(API.url)/item"
    static let friends = "\(API.url)/users"
    
    static func requestHeaders() -> [String: String]? {
        guard let accessToken = AccessToken.current else {
            return nil
        }
        let headers = ["user_id": accessToken.userId!, "token": accessToken.authenticationToken, "owner_id": accessToken.userId!]
        return headers
    }
}
