//
//  ViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/2/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let addFriends: AddFriendsViewController = AddFriendsViewController(nibName: "AddFriendsViewController", bundle: nil)
    let friends: FriendsViewController = FriendsViewController(nibName: "FriendsViewController", bundle: nil)
    let todoLists: TodoListsViewController = TodoListsViewController(nibName: "TodoListsViewController", bundle: nil)
    let profile: ProfileViewController = ProfileViewController(nibName: "ProfileViewController", bundle: nil)

    self.addChildViewController(addFriends)
    self.scrollView.addSubview(addFriends.view)
    addFriends.didMove(toParentViewController: self)

    self.addChildViewController(friends)
    self.scrollView.addSubview(friends.view)
    friends.didMove(toParentViewController: self)

    self.addChildViewController(todoLists)
    self.scrollView.addSubview(todoLists.view)
    todoLists.didMove(toParentViewController: self)

    self.addChildViewController(profile)
    self.scrollView.addSubview(profile.view)
    profile.didMove(toParentViewController: self)

    var addFriendsFrame: CGRect = addFriends.view.frame
    addFriendsFrame.origin.x = 0 * self.view.frame.width
    addFriends.view.frame = addFriendsFrame

    var friendsFrame: CGRect = friends.view.frame
    friendsFrame.origin.x = self.view.frame.width
    friends.view.frame = friendsFrame

    var todoListsFrame: CGRect = todoLists.view.frame
    todoListsFrame.origin.x = 2 * self.view.frame.width
    todoLists.view.frame = todoListsFrame

    var profileFrame: CGRect = profile.view.frame
    profileFrame.origin.x = 3 * self.view.frame.width
    profile.view.frame = profileFrame

    self.scrollView.contentSize = CGSize(width: self.view.frame.width * 4, height: self.view.frame.size.height)
    self.scrollView.setContentOffset(CGPoint(x: todoListsFrame.origin.x, y: todoListsFrame.origin.y), animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

}
