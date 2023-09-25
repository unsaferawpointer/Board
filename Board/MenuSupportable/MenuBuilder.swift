//
//  MenuBuilder.swift
//  Board
//
//  Created by Anton Cherkasov on 25.09.2023.
//

import Cocoa

final class MenuBuilder { }

extension MenuBuilder {

	static func makeMain() -> NSMenu {

		let menu = NSMenu(title: "Main")

		let appItem = makeSection(withTitle: "Board", for: [.quit])
		let editItem = makeSection(
			withTitle: "Edit",
			for: [.new, .separator, .markAsUrgent, .markAsNonUrgent, .separator, .setEstimation, .separator, .delete]
		)

		menu.addItem(appItem)
		menu.addItem(editItem)

		return menu
	}

	static func makeMenu(withTitle title: String, for items: [MenuBuilder.Item]) -> NSMenu {
		let menu = NSMenu()
		menu.title = title
		for item in items {
			menu.addItem(item.makeItem())
		}
		return menu
	}

	static func makeSection(withTitle title: String, for items: [Item]) -> NSMenuItem {
		let item = NSMenuItem()
		item.title = title
		item.submenu = makeMenu(withTitle: title, for: items)
		return item
	}
}
