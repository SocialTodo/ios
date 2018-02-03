//
//  ScrollableViewController.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 2/2/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class ScrollableViewController: UIViewController {
    let scrollView: UIScrollView
    let dataController: DataController
    
    init(dataController: DataController, scrollView: UIScrollView) {
        self.dataController = dataController
        self.scrollView = scrollView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
