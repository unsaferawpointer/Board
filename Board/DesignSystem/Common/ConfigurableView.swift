//
//  ConfigurableView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

protocol ConfigurableView: NSView {

	associatedtype Configuration

	/// Basic initialization
	///
	/// - Parameters:
	///    - configuration: Initial configuration
	init(_ configuration: Configuration)

	/// Update view
	///
	/// - Parameters:
	///    - configuration: New configuration
	func configure(_ configuration: Configuration)
}
