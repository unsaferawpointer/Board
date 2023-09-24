//
//  AppRouter.swift
//  Board
//
//  Created by Anton Cherkasov on 02.09.2023.
//

import Cocoa

/// App router interface
protocol Routable {

	/// Show main window
	///
	/// - Parameters:
	///    - sidebar: Sidebar view-controller
	///    - detail: Detail view-controller
	func showWindowAndOrderFront(sidebar: NSViewController, detail: NSViewController)

	func presentDetail(_ viewController: NSViewController)
}

/// AppRouter of the App
final class AppRouter: NSObject {

	// MARK: - UI-Properties

	private var toolbarItems: [NSToolbarItem] = []

	private var mainWindow: NSWindow

	lazy private var toolbar: NSToolbar = {
		let toolbar = NSToolbar(identifier: "toolbar")
		toolbar.sizeMode = .regular
		toolbar.displayMode = .iconOnly
		toolbar.delegate = self
		return toolbar
	}()

	private var splitViewController: NSSplitViewController? {
		mainWindow.contentViewController as? NSSplitViewController
	}

	// MARK: - Initialization

	/// Basic initialization
	override init() {
		self.mainWindow = NSWindow.makeDefault()
		super.init()
		mainWindow.toolbar = toolbar
	}
}

// MARK: - Routable
extension AppRouter: Routable {

	func showWindowAndOrderFront(sidebar: NSViewController, detail: NSViewController) {
		configureUserInterface(sidebar: sidebar, detail: detail)
		mainWindow.makeKeyAndOrderFront(nil)
	}

	func presentDetail(_ viewController: NSViewController) {
		guard let splitViewController else {
			return
		}

		if splitViewController.splitViewItems.count == 2 {
			let splitItem = splitViewController.splitViewItems[1]
			splitViewController.removeSplitViewItem(splitItem)
		}

		let new = NSSplitViewItem(viewController: viewController)
		splitViewController.addSplitViewItem(new)
	}
}

// MARK: - Helpers
private extension AppRouter {

	func configureUserInterface(sidebar: NSViewController, detail: NSViewController) {
		let contentViewController = NSSplitViewController()
		let primaryItem = 		makeSidebar(sidebar)
		let secondaryItem = 	makeDetail(detail)
		contentViewController.addSplitViewItem(primaryItem)
		contentViewController.addSplitViewItem(secondaryItem)
		mainWindow.contentViewController = contentViewController
		mainWindow.toolbar = toolbar
	}
}

// MARK: - Items factory
private extension AppRouter {

	func makeSidebar(_ viewController: NSViewController) -> NSSplitViewItem {
		let item = NSSplitViewItem(sidebarWithViewController: viewController)
		item.allowsFullHeightLayout = true
		item.titlebarSeparatorStyle = .automatic
		return item
	}

	func makeDetail(_ viewController: NSViewController) -> NSSplitViewItem {
		let item = NSSplitViewItem(viewController: viewController)
		item.allowsFullHeightLayout = true
		item.titlebarSeparatorStyle = .automatic

		if let toolbarSupportable = viewController as? ToolbarSupportable {
			let items = toolbarSupportable.makeToolbarItems()
			updateToolbarItems(newItems: items)
		} else {
			updateToolbarItems(newItems: [])
		}
		return item
	}
}

// MARK: - NSToolbarDelegate
extension AppRouter: NSToolbarDelegate {

	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems.map(\.itemIdentifier)
	}

	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems.map(\.itemIdentifier)
	}

	func toolbar(_ toolbar: NSToolbar,
				 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
				 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		return toolbarItems.first { $0.itemIdentifier == itemIdentifier }
	}
}

// MARK: - Toolbar support
extension AppRouter {

	private func updateToolbarItems(newItems: [NSToolbarItem]) {

		guard let toolbar = mainWindow.toolbar else {
			return
		}
		let difference = newItems.difference(from: toolbarItems) { new, old in
			return new.itemIdentifier == old.itemIdentifier
		}
		for change in difference {
			switch change {
			case .remove(let offset, _, _):
				toolbarItems.remove(at: offset)
				toolbar.removeItem(at: offset)
			case .insert(let offset, let item, _):
				toolbarItems.insert(item, at: offset)
				toolbar.insertItem(withItemIdentifier: item.itemIdentifier, at: offset)
			}
		}
	}
}
