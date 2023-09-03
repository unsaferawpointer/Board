//
//  LabelConfig.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

/// Configuration of the label
struct LabelConfig: TableItem {

	typealias View = LabelView

	static var reuseIdentifier: String = "label"

	/// Label identifier
	var id: NavigationItem

	/// Cell title
	var title: String

	/// Icon name
	var iconName: String?

	var selected: (() -> Void)?
}

// MARK: - Equatable
extension LabelConfig: Equatable {

	static func == (lhs: LabelConfig, rhs: LabelConfig) -> Bool {
		return	lhs.title == rhs.title && lhs.iconName == rhs.iconName
	}
}
