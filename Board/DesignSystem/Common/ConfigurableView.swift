//
//  ConfigurableView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

protocol ConfigurableView: NSView {

	associatedtype Configuration

	static var reuseIdentifier: String { get }

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
