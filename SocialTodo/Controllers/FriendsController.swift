//
//  FriendsController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/11/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class FriendsController {
    func getFriends(completion: @escaping ([Friend], [Int: UIImage]) -> Void) {
        var friends = [Friend]()
        var friendsImages = [Int: UIImage]()
        guard let headers = API.requestHeaders() else {
            return
        }
        let urlRequest = URLRequest(url: API.friends, method: "GET", headers: headers)
        
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
                let dispatchGroup = DispatchGroup()
                let backgroundThread = DispatchQueue.global()
                for friend in friends {
                    dispatchGroup.enter()
                    backgroundThread.async {
                        self.getFriendImage(facebookId: friend.facebookUserId) { (profileImage) in
                            friendsImages[friend.facebookUserId] = profileImage
                            print("friendsImages set")
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: backgroundThread, execute: {
                    print(friends.count, friendsImages.count)
                    completion(friends, friendsImages)
                    print("completion called")
                })
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func getFriendImage(facebookId: Int, completion: @escaping (UIImage) -> Void) {
        // https://graph.facebook.com/userid/picture?type=large
        let url = URL(string: "https://graph.facebook.com/\(facebookId)/picture?type=small")!
        let urlRequest = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            if let data = data {
                if let profileImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(profileImage)
                    }
                }
                
            }
        }
        task.resume()
    }
}
