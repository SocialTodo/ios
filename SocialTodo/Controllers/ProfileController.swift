//
//  ProfileController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/10/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class ProfileController {
    func getUserProfile(completion: @escaping (User, UIImage) -> Void) {
        guard let headers = API.requestHeaders() else {
            return
        }
        let urlRequest = URLRequest(url: API.me, method: "GET", headers: headers)
        
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
                let user = try JSONDecoder().decode(User.self, from: responseData)
                self.getUserImage(facebookId: user.facebookUserId) { (profileImage) in
                    let userImage = profileImage
                    DispatchQueue.main.async {
                        completion(user, userImage)
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func getUserImage(facebookId: Int, completion: @escaping (UIImage) -> Void) {
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
