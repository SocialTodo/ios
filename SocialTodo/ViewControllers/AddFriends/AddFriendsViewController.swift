//
//  AddFriendsViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class AddFriendsViewController: UIViewController {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let friendsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("Friends", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(red: 221/255, green: 242/255, blue: 255/255, alpha: 1)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()
    
    let scrollView: UIScrollView

    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Add+"

		navigationItem.rightBarButtonItem = friendsButton
		friendsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFriends)))

		view.addSubview(background)
		setupLayout()
        

	}

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
	}

	@objc func showFriends() {
		print("show friends")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0.0), animated: true)
	}

}
