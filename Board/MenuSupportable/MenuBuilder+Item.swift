//
//  MenuBuilder+Item.swift
//  Board
//
//  Created by Anton Cherkasov on 25.09.2023.
//

import Cocoa

extension MenuBuilder {

	enum Item {
		case new
		case markAsUrgent
		case markAsNonUrgent
		case setEstimation
		case delete

		case quit

		case separator
	}
}

extension MenuBuilder.Item {

	func makeItem() -> NSMenuItem {
		switch self {
		case .markAsUrgent:
			return NSMenuItem(
				title: "Mark as urgent",
				action: #selector(MenuSupportable.markAsUrgent),
				keyEquivalent: "u"
			)
		case .markAsNonUrgent:
			return NSMenuItem(
				title: "Mark as non-urgent",
				action: #selector(MenuSupportable.markAsNonUrgent),
				keyEquivalent: "U"
			)
		case .setEstimation:
			let item = NSMenuItem()
			item.title = "Set estimation"
			item.submenu = NSMenu()
			for (index, number) in [0, 1, 2, 3, 5, 8, 13, 21, 34, 55].enumerated() {
				item.submenu?.addItem(
					withTitle: "\(number) sp",
					action: #selector(MenuSupportable.setEstimation(_:)),
					keyEquivalent: "\(index)"
				)
				item.submenu?.items.last?.tag = number
			}
			return item
		case .delete:
			return NSMenuItem(
				title: "Delete",
				action: #selector(MenuSupportable.delete),
				keyEquivalent: "\u{0008}"
			)
		case .separator:
			return .separator()
		case .new:
			return NSMenuItem(
				title: "New",
				action: #selector(MenuSupportable.createNew),
				keyEquivalent: "n"
			)
		case .quit:
			return NSMenuItem(
				title: "Quit",
				action: #selector(MenuSupportable.quit),
				keyEquivalent: "q"
			)
		}
	}
}
