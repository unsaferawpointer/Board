//
//  NSScrollView+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

extension NSScrollView {

	static var plain: NSScrollView {
		let view = NSScrollView()
		view.borderType = .noBorder
		view.hasHorizontalScroller = false
		view.autohidesScrollers = true
		view.hasVerticalScroller = true
		view.automaticallyAdjustsContentInsets = true
		view.drawsBackground = false
		return view
	}
}
