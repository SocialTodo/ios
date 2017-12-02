//
//  AuthControllerInterface.swift
//  SocialTodo
//
//  Created by Brannen Hall on 17-12-02.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import Foundation

protocol AuthControllerInterface {
  //Use an implictly unwrapped optional because AppDelegate does not use traditional initializers.
  var authController: AuthController! { get }
}

extension AuthControllerInterface {

}
