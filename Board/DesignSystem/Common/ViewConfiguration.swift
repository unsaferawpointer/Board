//
//  ViewConfiguration.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

protocol ViewConfiguration {

	associatedtype View: ConfigurableView where View.Configuration == Self

}

// MARK: - Default methods
extension ViewConfiguration {

	/// Make field based on this configuration
	func makeView() -> NSView {
		return View(self)
	}
}
