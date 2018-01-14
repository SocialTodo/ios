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

	override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

  override func viewDidLoad() {
    super.viewDidLoad()

		let lightNavColor = UIColor(red: 0/255, green: 217/255, blue: 250/255, alpha: 1)
		let darkNavColor = UIColor(red: 3/255, green: 144/255, blue: 231/255, alpha: 1)

		setupViewController(viewController: AddFriendsViewController(), navColor: lightNavColor, index: 0)
		setupViewController(viewController: FriendsViewController(), navColor: lightNavColor, index: 1)
		setupViewController(viewController: TodoListsViewController(), navColor: darkNavColor, index: 2)
		setupViewController(viewController: ProfileViewController(), navColor: lightNavColor, index: 3)

    self.scrollView.contentSize = CGSize(width: self.view.frame.width * 4, height: self.view.frame.size.height)
  }

	func setupViewController(viewController: UIViewController, navColor: UIColor, index: CGFloat) {
		let navController = UINavigationController(rootViewController: viewController)
		navController.navigationBar.barTintColor = navColor
		navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 28) ?? UIFont.boldSystemFont(ofSize: 28), NSAttributedStringKey.foregroundColor: UIColor.white]

		addToScrollView(viewController: navController, index: index)

	}

	func addToScrollView(viewController: UIViewController, index: CGFloat) {
		addChildViewController(viewController)
		scrollView.addSubview(viewController.view)
		viewController.didMove(toParentViewController: self)

		var frame: CGRect = viewController.view.frame
		frame.origin.x = index * self.view.frame.width
		viewController.view.frame = frame

		if index == 2 {
			self.scrollView.setContentOffset(CGPoint(x: viewController.view.frame.origin.x, y: viewController.view.frame.origin.y), animated: true)
		}
	}

}
