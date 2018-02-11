//
//  FriendsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/11/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

class FriendsController {
    func getFriends(completion: @escaping ([Friend], [Int: UIImage]) -> Void) {
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
            var friendsImages = [Int: UIImage]()
            for friend in friends {
                self.getFriendImage(facebookId: friend.facebookUserId) { (profileImage) in
                    friendsImages[friend.facebookUserId] = profileImage
                }
            }
            DispatchQueue.main.async {
                completion(friends, friendsImages)
            }
        }
        
        task.resume()
    }
    func getFriendImage(facebookId: Int, completion: @escaping (UIImage) -> Void) {
        // https://graph.facebook.com/userid/picture?type=large
        let url = URL(string: "https://graph.facebook.com/\(facebookId)/picture?type=large")!
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            if let data = data {
                if let profileImage = UIImage(data: data) {
                    completion(profileImage)
                }
                
            }
        }
        task.resume()
    }
}
