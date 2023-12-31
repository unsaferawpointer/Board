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
		reloadTable(models)
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

		table.addColumn(.isUrgent, withTitle: "Urgent", style: .toggle)
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
					$0.action = #selector(createNew)
				}
				$0.action = #selector(createNew)
			}
		]
	}
}

// MARK: - Menu support
private extension BacklogUnitView {
	
	func makeMenu() -> NSMenu {
		return MenuBuilder.makeMenu(
			withTitle: "",
			for: [
				.new,
				.separator,
				.markAsUrgent,
				.markAsNonUrgent,
				.separator,
				.setEstimation,
				.separator,
				.delete
			]
		)
	}
}

// MARK: - MenuSupportable
extension BacklogUnitView: MenuSupportable {

	@objc
	func createNew() {
		output?.buttonToCreateHasBeenClicked()
	}

	@objc
	func delete() {
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToDeleteHasBeenClicked(for: selected)
	}

	@objc
	func markAsUrgent() {
		let selected = table.effectiveSelection().map { row in
			models[row].id
		}
		output?.menuItemToMarkUrgentHasBeenClicked(for: selected)
	}

	@objc
	func markAsNonUrgent() {
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
