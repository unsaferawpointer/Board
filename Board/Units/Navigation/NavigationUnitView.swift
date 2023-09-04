//
//  NavigationUnitView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

let NSOutlineViewNoSelectionIndex: Int = -1

protocol NavigationView: AnyObject {

	func display(_ labels: [LabelConfig])

	func select(_ item: NavigationItem)
}

final class NavigationUnitView: NSViewController {

	// MARK: - Data

	var labels: [LabelConfig] = []

	// MARK: - DI

	var output: ViewOutput?

	// MARK: - UI-Properties

	lazy var scrollview: NSScrollView = {
		let view = NSScrollView()
		view.borderType = .noBorder
		view.hasHorizontalScroller = false
		view.autohidesScrollers = true
		view.hasVerticalScroller = true
		view.automaticallyAdjustsContentInsets = true
		view.drawsBackground = false
		return view
	}()

	lazy var table: NSOutlineView = {
		let view = NSOutlineView()
		view.style = .sourceList
		view.rowSizeStyle = .default
		view.floatsGroupRows = false
		view.allowsMultipleSelection = false
		view.allowsColumnResizing = false
		view.usesAlternatingRowBackgroundColors = false
		view.usesAutomaticRowHeights = false
		return view
	}()

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configure: Configuration closure. Setup unit here.
	init(_ configure: (NavigationUnitView) -> Void) {
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

// MARK: - NavigationView
extension NavigationUnitView: NavigationView {

	func display(_ labels: [LabelConfig]) {
		self.labels = labels
		table.reloadData()
	}

	func select(_ item: NavigationItem) {
		guard let index = labels.firstIndex(where: { $0.id == item }) else {
			return
		}
		let indexSet = IndexSet(integer: index)
		table.selectRowIndexes(indexSet, byExtendingSelection: false)
	}
}

// MARK: - Helpers
private extension NavigationUnitView {

	func configureUserInterface() {

		scrollview.documentView = table

		let column = NSTableColumn(identifier: .init("main"))
		column.resizingMask = [.autoresizingMask, .userResizingMask]
		table.addTableColumn(column)
		table.headerView = nil

		table.dataSource = self
		table.delegate = self
	}
}

// MARK: - NSOutlineViewDataSource
extension NavigationUnitView: NSOutlineViewDataSource {

	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
		return labels.count
	}

	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
		return labels[index]
	}

	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
		return false
	}
}

// MARK: - NSOutlineViewDelegate
extension NavigationUnitView: NSOutlineViewDelegate {

	func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
		guard let configuration = item as? LabelConfig else {
			return nil
		}
		return makeFieldIfNeeded(outlineView, configuration: configuration)
	}

	func outlineViewSelectionDidChange(_ notification: Notification) {
		let row = table.selectedRow
		guard row != NSOutlineViewNoSelectionIndex else {
			return
		}
		labels[row].selected?()
	}
}

// MARK: - Helpers
private extension NavigationUnitView {

	func makeFieldIfNeeded<T: ViewConfiguration, View: ConfigurableView>(
		_ table: NSOutlineView, configuration: T
	) -> NSView? where T.View == View {
		let id = NSUserInterfaceItemIdentifier("label")
		var view = table.makeView(withIdentifier: id, owner: self) as? View
		if view == nil {
			view = View(configuration)
			view?.identifier = id
		}
		view?.configure(configuration)
		return view
	}
}
