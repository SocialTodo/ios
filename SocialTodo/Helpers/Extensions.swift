//
//  Extensions.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/24/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func size(height: CGFloat? = nil, width: CGFloat? = nil) {
		if let height = height {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
		if let width = width {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
    func anchorX(left: NSLayoutXAxisAnchor? = nil, leftConstant: CGFloat? = nil, right: NSLayoutXAxisAnchor? = nil, rightConstant: CGFloat? = nil) {
		if let left = left {
            if let leftConstant = leftConstant {
                leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
            } else {
                leftAnchor.constraint(equalTo: left).isActive = true
            }
		}
		if let right = right {
            if let rightConstant = rightConstant {
                rightAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
            } else {
                rightAnchor.constraint(equalTo: right).isActive = true
            }
		}
	}
	func anchorY(top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat? = nil, bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat? = nil) {
		if let top = top {
            if let topConstant = topConstant {
                topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
            } else {
                topAnchor.constraint(equalTo: top).isActive = true
            }
		}
		if let bottom = bottom {
            if let bottomConstant = bottomConstant {
                bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true
            } else {
                bottomAnchor.constraint(equalTo: bottom).isActive = true
            }
		}
	}
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}

extension URLRequest {
    init(url: String, method: String, headers: [String: String]) {
        let url = URL(string: url)!
        self.init(url: url)
        allHTTPHeaderFields = headers
        httpMethod = method
    }
}
