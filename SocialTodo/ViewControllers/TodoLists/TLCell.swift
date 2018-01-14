//
//  TL-Cell.swift
//  SocialTodo
//
//  Created by Saatvik Arya on 1/13/18.
//  Copyright © 2018 Saatvik Arya. All rights reserved.
//

import UIKit

class TLCell: UITableViewCell {

	let background: UIImageView = {
		let iv = UIImageView()
		iv.image = #imageLiteral(resourceName: "TLCell")
		return iv
	}()

	let label: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "AvenirNext-DemiBold", size: 22.0)
		label.text = "Todo List"
		return label
	}()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.backgroundColor = UIColor.clear
		contentView.backgroundColor = UIColor.clear
		self.selectionStyle = .none

		addSubview(background)
		addSubview(label)

		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupLayout() {
		background.translatesAutoresizingMaskIntoConstraints = false
		background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
		background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
		background.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
		background.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
		background.heightAnchor.constraint(equalToConstant: 60).isActive = true

		label.translatesAutoresizingMaskIntoConstraints = false
		label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
		label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
		label.heightAnchor.constraint(equalToConstant: 50).isActive = true

	}
}
