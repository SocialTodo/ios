//
//  FriendsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/11/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation

class FriendsController {
    func getFriends(completion: @escaping ([Friend]) -> Void) {
        var friends = [Friend]()
        guard let headers = API.requestHeaders() else {
            return
        }
        let urlRequest = URLRequest(url: API.users, method: "GET", headers: headers)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                friends = try JSONDecoder().decode([Friend].self, from: responseData)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                completion(friends)
            }
        }
        
        task.resume()
    }
}
