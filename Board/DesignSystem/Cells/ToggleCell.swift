//
//  ToggleCell.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

/// NSTableView toggle cell
final class ToggleCell: NSView {

	var configuration: Configuration?

	lazy private var field = NSButton()
}

// MARK: - ConfigurableView
extension ToggleCell: ConfigurableView {

	typealias Configuration = ToggleItem

	static var reuseIdentifier: String = "togglecell"

	convenience init(_ configuration: Configuration) {
		self.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		updateUserInterface(configuration)
	}

	func configure(_ configuration: Configuration) {
		updateUserInterface(configuration)
	}
}

// MARK: - Helpers
private extension ToggleCell {

	func configureUserInterface() {
		field.setButtonType(.toggle)
		field.isBordered = false
		field.target = self
		field.action = #selector(fieldDidChangeState(_:))
	}

	func updateUserInterface(_ configuration: Configuration) {
		self.configuration = configuration

		field.image = NSImage(symbolName: configuration.image)
		field.alternateImage = NSImage(symbolName: configuration.alternativeImage)
		field.contentTintColor = configuration.isEnable
									? configuration.tintColor
									: .tertiaryLabelColor
		field.state = configuration.isEnable ? .on : .off
	}

	func configureConstraints() {

		addSubviews([field])

		field.constraint(.leading, to: .leading, inView: self, withOffset: .small)
		field.constraint(.trailing, to: .trailing, inView: self, withOffset: .minusSmall)
		field.constraint(.centerY, to: .centerY, inView: self)
	}
}

// MARK: - Actions
extension ToggleCell {

	@objc
	func fieldDidChangeState(_ sender: NSButton) {
		let state = sender.state == .on
		guard var configuration else {
			return
		}
		configuration.isEnable = state
		updateUserInterface(configuration)
		configuration.action?(state)
	}
}
