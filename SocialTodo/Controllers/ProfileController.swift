//
//  ProfileController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/10/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import FacebookCore

class ProfileController {
    func getUserProfile(completion: @escaping (UIImage) -> Void) {
        // https://graph.facebook.com/userid/picture?type=large
        guard let accessToken = AccessToken.current else {
            return 
        }
        let url = URL(string: "https://graph.facebook.com/\(accessToken.userId!)/picture?type=large")!
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
