//
//  BacklogUnitView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

final class BacklogUnitView: NSViewController {

	// MARK: - Data

	var models: [BacklogRowModel] = []

	// MARK: - DI

	var output: BacklogViewOutput?

	// MARK: - UI-Properties

	lazy var scrollview = NSScrollView.plain

	lazy var table = NSTableView.inset

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configure: Configuration closure. Setup unit here.
	init(_ configure: (BacklogUnitView) -> Void) {
		super.init(nibName: nil, bundle: nil)
		configure(self)
		configureUserInterface()
	}

	@available(*, unavailable, message: "Use init()")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life-cycle

	override func loadView() {
		self.view = scrollview
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		output?.viewDidChangeState(.viewDidLoad)
	}
}

// MARK: - BacklogView
extension BacklogUnitView: BacklogView {

	func display(_ models: [BacklogRowModel]) {
		self.models = (models as NSArray).sortedArray(using: table.sortDescriptors) as! [BacklogRowModel]
		table.reloadData()
	}
}

// MARK: - Helpers
private extension BacklogUnitView {

	func configureUserInterface() {

		scrollview.documentView = table

		table.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle

		table.addColumn(.description, withTitle: "Description", style: .flexible(min: 120, max: nil))
		table.tableColumns.last?.sortDescriptorPrototype = NSSortDescriptor(keyPath: \BacklogRowModel.text, ascending: true)
		
		table.addColumn(.estimation, withTitle: "Estimation", style: .flexible(min: 78, max: 78))
		table.tableColumns.last?.sortDescriptorPrototype = NSSortDescriptor(keyPath: \BacklogRowModel.estimation, ascending: true)

		table.addColumn(.isUrgent, withTitle: "􀋦", style: .toggle)
		table.tableColumns.last?.sortDescriptorPrototype = NSSortDescriptor(keyPath: \BacklogRowModel.isUrgent, ascending: true)

		table.dataSource = self
		table.delegate = self

		table.menu = makeMenu()
	}
}

// MARK: - ToolbarSupportable
extension BacklogUnitView: ToolbarSupportable {

	func makeToolbarItems() -> [NSToolbarItem] {
		return [
			NSToolbarItem(itemIdentifier: .init(rawValue: "newObject")).configure {
				$0.isNavigational = false
				$0.visibilityPriority = .high
				$0.view = NSButton().configure {
					$0.bezelStyle = .texturedRounded
					$0.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
					$0.target = self
					$0.action = #selector(newTask(_:))
				}
				$0.action = #selector(newTask(_:))
			}
		]
	}
}

private extension BacklogUnitView {
	
	func makeMenu() -> NSMenu {
		let menu: NSMenu = {
			
			let menu = NSMenu()
			
			menu.addItem(withTitle: "Set estimation", action: nil, keyEquivalent: "\r")
			menu.items.last?.submenu = NSMenu()
			
			for number in [0, 1, 2, 3, 5, 8, 13, 21, 33, 54] {
				menu.items.last?.submenu?.addItem(
					withTitle: "\(number) sp",
					action: #selector(setEstimation(_:)),
					keyEquivalent: ""
				)
				menu.items.last?.submenu?.items.last?.tag = number
			}
			
			menu.addItem(.separator())

			menu.addItem(withTitle: "Mark as urgent", action: #selector(markAsUrgent(_:)), keyEquivalent: "")
			menu.addItem(withTitle: "Mark as non-urgent", action: #selector(markAsNonUrgent(_:)), keyEquivalent: "")
			
			menu.addItem(.separator())
			
			menu.addItem(withTitle: "Delete", action: #selector(delete(_:)), keyEquivalent: "\u{0008}")
			menu.items.last?.image = NSImage(symbolName: "trash")
			
			return menu
		}()
		return menu
	}
}

// MARK: - Actions
extension BacklogUnitView {

	@objc
	func newTask(_ sender: Any) {
		output?.buttonToCreateHasBeenClicked()
	}
	
	@objc
	func delete(_ sender: Any) {
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToDeleteHasBeenClicked(for: selected)
	}
	
	@objc
	func markAsUrgent(_ sender: Any) {
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToMarkUrgentHasBeenClicked(for: selected)
	}
	
	@objc
	func markAsNonUrgent(_ sender: Any) {
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToMarkNonUrgentHasBeenClicked(for: selected)
	}
	
	@objc
	func setEstimation(_ sender: NSMenuItem) {
		let estimation = sender.tag
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToSetEstimationHasBeenClicked(estimation: estimation, for: selected)
	}
}

extension BacklogUnitView: NSMenuItemValidation {

	func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
		return true
	}
}

// MARK: - Columns identifiers
extension NSUserInterfaceItemIdentifier {

	static let description = NSUserInterfaceItemIdentifier("description")
	static let estimation = NSUserInterfaceItemIdentifier("estimation")
	static let isUrgent = NSUserInterfaceItemIdentifier("isUrgent")
}

protocol Configurable: AnyObject { }

extension Configurable {
	func configure(_ block: (Self) -> Void) -> Self {
		block(self)
		return self
	}
}

extension NSObject: Configurable { }
