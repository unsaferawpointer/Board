//
//  NSTableView+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

extension NSTableView {

	static var inset: NSTableView {
		let view = NSTableView()
		view.style = .inset
		view.rowSizeStyle = .default
		view.floatsGroupRows = false
		view.allowsMultipleSelection = true
		view.allowsColumnResizing = false
		view.usesAlternatingRowBackgroundColors = true
		view.usesAutomaticRowHeights = false
		return view
	}
}

extension NSTableView {

	@discardableResult
	func addColumn(
		_ identifier: NSUserInterfaceItemIdentifier,
		withTitle title: String,
		style: ColumnStyle
	) -> Self {
		let column = NSTableColumn(identifier: identifier)

		if let width = style.minWidth {
			column.minWidth = width
		}
		if let width = style.maxWidth {
			column.maxWidth = width
		}
		column.title = title
		if let alignment = style.alignment {
			column.headerCell.alignment = alignment
		}
		column.resizingMask = .autoresizingMask
		addTableColumn(column)
		return self
	}

	enum ColumnStyle {
		case flexible(min: CGFloat?, max: CGFloat?)
		case toggle
	}
}

extension NSTableView.ColumnStyle {

	var alignment: NSTextAlignment? {
		switch self {
		case .flexible:
			return nil
		case .toggle:
			return .center
		}
	}

	var minWidth: CGFloat? {
		switch self {
		case .flexible(let min, _):
			return min
		case .toggle:
			return 42
		}
	}

	var maxWidth: CGFloat? {
		switch self {
		case .flexible(_ , let max):
			return max
		case .toggle:
			return 64
		}
	}
}

extension NSTableView {
	
	func effectiveSelection() -> IndexSet {
		if clickedRow != -1 {
			if selectedRowIndexes.contains(clickedRow) {
				return selectedRowIndexes
			} else {
				return IndexSet(integer: clickedRow)
			}
		} else {
			return selectedRowIndexes
		}
	}
}

// MARK: - Animations
extension NSTableView {

	func removeRows(at index: Int, withAnimation animation: AnimationOptions = [.effectFade, .slideDown]) {
		self.removeRows(at: .init(integer: index), withAnimation: animation)
	}

	func insertRows(at index: Int, withAnimation animation: AnimationOptions = [.effectFade, .slideRight]) {
		self.insertRows(at: .init(integer: index), withAnimation: animation)
	}
}
