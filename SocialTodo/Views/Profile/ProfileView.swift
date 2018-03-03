//
//  ProfileView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/3/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class ProfileView: ScrollableViewController {
    let profileController = ProfileController()

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "background")
		return iv
	}()

	let myListsButton: UIBarButtonItem = {
		let button = UIButton(type: .system)
		button.setTitle("My Lists", for: .normal)
		button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
		button.tintColor = UIColor(r: 221, g: 242, b: 255)
		let barButton = UIBarButtonItem(customView: button)
		return barButton
	}()
    
    let profileImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "profile"))
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 150/2
        return iv
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.text = "First Last"
        return label
    }()
    
    let userClaps: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "12 ", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)])
        text.append(NSAttributedString(string: "Claps", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]))
        label.attributedText = text
       return label
    }()
    
    func createUserClapsText(clapCount: Int) -> NSAttributedString {
        let text = NSMutableAttributedString(string: "\(clapCount) ", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)])
        text.append(NSAttributedString(string: "Claps", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]))
        return text

    }
    
    let userFriends: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "4 ", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)])
        text.append(NSAttributedString(string: "Friends", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]))
        label.attributedText = text
        return label
    }()
    
    func createUserFriendsText(friendsCount: Int) -> NSAttributedString {
        let text = NSMutableAttributedString(string: "\(friendsCount) ", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)])
        text.append(NSAttributedString(string: "Friends", attributes: [NSAttributedStringKey.font: UIFont(name: "AvenirNext-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]))
        return text
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Profile"

		navigationItem.leftBarButtonItem = myListsButton
		myListsButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMyLists)))

		setupLayout()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        profileController.getUserProfile() { (user, userImage) in
            self.profileImage.image = userImage
            self.userName.text = user.name
            self.userClaps.attributedText = self.createUserClapsText(clapCount: user.claps)
            self.userFriends.attributedText = self.createUserFriendsText(friendsCount: user.friends)
        }
    }

	func setupLayout() {
        view.addSubview(background)
        view.addSubview(profileImage)
        view.addSubview(userName)
        
		background.translatesAutoresizingMaskIntoConstraints = false
        background.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        background.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
        
        let margins = view.layoutMarginsGuide
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        profileImage.anchorY(top: margins.topAnchor, topConstant: 18)
        profileImage.size(height: 150, width: 150)
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        userName.anchorY(top: profileImage.bottomAnchor, topConstant: 8)
        
        let stackView = UIStackView(arrangedSubviews: [userClaps, userFriends])
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        stackView.anchorY(top: userName.bottomAnchor, topConstant: 12)
        
	}

	@objc func showMyLists() {
		print("show my lists")
        scrollView.setContentOffset(CGPoint(x: self.view.frame.width * 1, y: 0.0), animated: true)
	}

}
