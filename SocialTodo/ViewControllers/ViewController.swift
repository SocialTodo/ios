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

		let addFriendsStoryboard = UIStoryboard(name: "AddFriends", bundle: nil)
		let addFriends = addFriendsStoryboard.instantiateViewController(withIdentifier: "AddFriendsNav")
		self.addChildViewController(addFriends)
		self.scrollView.addSubview(addFriends.view)
		addFriends.didMove(toParentViewController: self)

		var addFriendsFrame: CGRect = addFriends.view.frame
		addFriendsFrame.origin.x = 0 * self.view.frame.width
		addFriends.view.frame = addFriendsFrame

		let friendsStoryboard = UIStoryboard(name: "Friends", bundle: nil)
		let friends = friendsStoryboard.instantiateViewController(withIdentifier: "FriendsNav")
		self.addChildViewController(friends)
		self.scrollView.addSubview(friends.view)
		friends.didMove(toParentViewController: self)

		var friendsFrame: CGRect = friends.view.frame
		friendsFrame.origin.x = self.view.frame.width
		friends.view.frame = friendsFrame

		let todoListsStoryboard = UIStoryboard(name: "TodoLists", bundle: nil)
		let todoLists = todoListsStoryboard.instantiateViewController(withIdentifier: "TodoListsNav")
		self.addChildViewController(todoLists)
		self.scrollView.addSubview(todoLists.view)
		todoLists.didMove(toParentViewController: self)

		var todoListsFrame: CGRect = todoLists.view.frame
		todoListsFrame.origin.x = 2 * self.view.frame.width
		todoLists.view.frame = todoListsFrame

		self.scrollView.setContentOffset(CGPoint(x: todoListsFrame.origin.x, y: todoListsFrame.origin.y), animated: true)

		let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
		let profile = profileStoryboard.instantiateViewController(withIdentifier: "ProfileNav")
		self.addChildViewController(profile)
		self.scrollView.addSubview(profile.view)
		profile.didMove(toParentViewController: self)

		var profileFrame: CGRect = profile.view.frame
		profileFrame.origin.x = 3 * self.view.frame.width
		profile.view.frame = profileFrame

    self.scrollView.contentSize = CGSize(width: self.view.frame.width * 4, height: self.view.frame.size.height)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

}
