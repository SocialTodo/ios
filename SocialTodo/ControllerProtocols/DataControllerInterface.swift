//
// Created by Brannen Hall on 17-12-18.
// Copyright (c) 2017 Saatvik Arya. All rights reserved.
//

protocol DataControllerInterface {
  //Use an implictly unwrapped optional because AppDelegate does not use traditional initializers.
  var dataController: DataController! { get }
}

extension DataControllerInterface {
  
}
