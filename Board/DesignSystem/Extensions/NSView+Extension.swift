//
//  NSView+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Cocoa

extension NSView {

	func attachEdges(_ edges: Edges, toView view: NSView, inset: CGFloat = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		if !view.subviews.contains(where: { $0 === self }) {
			view.addSubview(self)
		}
		if edges.contains(.top) {
			topAnchor.constraint(equalTo: view.topAnchor, constant: inset)
				.isActive = true
		}
		if edges.contains(.leading) {
			leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset)
				.isActive = true
		}
		if edges.contains(.trailing) {
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset)
				.isActive = true
		}
		if edges.contains(.bottom) {
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset)
				.isActive = true
		}
	}

	func addSubviews(_ views: [NSView]) {
		views.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
	}

	func constraint(
		_ anchor: LayoutXAxisAnchor,
		to other: LayoutXAxisAnchor,
		inView view: NSView,
		withOffset offset: CGFloat = 0
	) {
		layoutXAxisAnchor(for: anchor).constraint(
			equalTo: view.layoutXAxisAnchor(for: other),
			constant: offset
		)
		.isActive = true
	}

	func constraint(
		_ anchor: LayoutYAxisAnchor,
		to other: LayoutYAxisAnchor,
		inView view: NSView,
		withOffset offset: CGFloat = 0
	) {
		layoutYAxisAnchor(for: anchor).constraint(
			equalTo: view.layoutYAxisAnchor(for: other),
			constant: offset
		)
		.isActive = true
	}

	func layoutXAxisAnchor(for anchor: LayoutXAxisAnchor) -> NSLayoutXAxisAnchor {
		switch anchor {
		case .leading:	return leadingAnchor
		case .centerX:	return centerXAnchor
		case .trailing:	return trailingAnchor
		}
	}

	func layoutYAxisAnchor(for anchor: LayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
		switch anchor {
		case .top:		return topAnchor
		case .centerY:	return centerYAnchor
		case .bottom:	return bottomAnchor
		}
	}

}

// MARK: - Nested data structs
extension NSView {

	enum LayoutYAxisAnchor {
		case top
		case centerY
		case bottom
	}

	enum LayoutXAxisAnchor {
		case leading
		case centerX
		case trailing
	}

	struct Edges: OptionSet {

		var rawValue: UInt8

		static var top = 			Edges(rawValue: 1 << 0)
		static var leading = 		Edges(rawValue: 1 << 1)
		static var trailing =		Edges(rawValue: 1 << 2)
		static var bottom =			Edges(rawValue: 1 << 3)

		static var all: Edges =		[.top, .leading, .trailing, .bottom]

	}
}
