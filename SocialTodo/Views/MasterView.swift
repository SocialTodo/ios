//
//  MasterView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/2/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class MasterView: UIViewController {
    //MARK:- Properties
    let authController = AuthController()
    
    //MARK:- UI Elements
	let scrollView: UIScrollView = {
		let sv = UIScrollView(frame: UIScreen.main.bounds)
		sv.isScrollEnabled = true
		sv.isPagingEnabled = true
		sv.showsVerticalScrollIndicator = false
		sv.showsHorizontalScrollIndicator = false
		sv.bounces = false
		sv.bouncesZoom = false
		sv.clipsToBounds = true
		return sv
	}()

    //MARK:- Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
        
		setupLayout()
		setupScrollView()
        
        authController.fetchStoredToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // if not logged in present LoginVC
        if authController.facebookToken == nil {
            self.present(LoginView(), animated: true, completion: nil)
        }
    }
        
    //MARK:- UI Layout
	func setupLayout() {
		view.addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        scrollView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
		self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.size.height)
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

		if index == 1 {
			self.scrollView.setContentOffset(CGPoint(x: viewController.view.frame.origin.x, y: viewController.view.frame.origin.y), animated: true)
		}
	}

	func setupScrollView() {
        setupViewController(viewController: FriendsView(scrollView: scrollView), navColor: UIColor.lightNavColor, index: 0)
		setupViewController(viewController: TodoListsView(scrollView: scrollView), navColor: UIColor.darkNavColor, index: 1)
		setupViewController(viewController: ProfileView(scrollView: scrollView), navColor: UIColor.lightNavColor, index: 2)
	}

}
