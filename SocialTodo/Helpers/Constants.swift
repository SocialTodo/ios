//
//  Constants.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
	static let lightNavColor = UIColor(red: 0/255, green: 217/255, blue: 250/255, alpha: 1)
	static let darkNavColor = UIColor(red: 3/255, green: 144/255, blue: 231/255, alpha: 1)
}

enum API {
    static let url = "http://localhost:8080/api"
    static let list = "\(API.url)/list"
    static let item = "\(API.url)/item"
    static let users = "\(API.url)/users"
}
