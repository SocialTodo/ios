//
//  MasterView.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 12/2/17.
//  Copyright © 2017 Saatvik Arya. All rights reserved.
//

import UIKit

class MasterView: UIViewController {
    let authController = AuthController()
    let dataController = DataController()
    
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

	override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

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
        

	func setupLayout() {
		view.addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.anchorX(left: view.leftAnchor, right: view.rightAnchor)
        scrollView.anchorY(top: view.topAnchor, bottom: view.bottomAnchor)
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
        print(frame.origin.x)
		viewController.view.frame = frame

		if index == 2 {
			self.scrollView.setContentOffset(CGPoint(x: viewController.view.frame.origin.x, y: viewController.view.frame.origin.y), animated: true)
		}
	}

	func setupScrollView() {

        setupViewController(viewController: AddFriendsView(dataController: dataController, scrollView: scrollView), navColor: Colors.lightNavColor, index: 0)
        setupViewController(viewController: FriendsView(dataController: dataController, scrollView: scrollView), navColor: Colors.lightNavColor, index: 1)
		setupViewController(viewController: TodoListsView(dataController: dataController, scrollView: scrollView), navColor: Colors.darkNavColor, index: 2)
		setupViewController(viewController: ProfileView(dataController: dataController, scrollView: scrollView), navColor: Colors.lightNavColor, index: 3)
	}

}