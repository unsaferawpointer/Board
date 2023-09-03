//
//  NSWindow+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 02.09.2023.
//

import Cocoa

extension NSWindow {

	static func makeDefault() -> NSWindow {
		let window = NSWindow()
		window.minSize = .init(width: 640, height: 480)
		window.styleMask = [
			.miniaturizable,
			.closable,
			.resizable,
			.titled,
			.fullSizeContentView,
			.unifiedTitleAndToolbar
		]
		window.isRestorable = true
		window.center()
		window.setFrameAutosaveName("main_window")
		window.titleVisibility = .visible
		window.titlebarAppearsTransparent = false
		window.toolbarStyle = .unified
		window.titlebarSeparatorStyle = .automatic
		window.identifier = .init("main_window")
		return window
	}
}
