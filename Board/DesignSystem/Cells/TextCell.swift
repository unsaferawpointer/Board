//
//  TextCell.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

/// NSTableView text cell
final class TextCell: NSView {

	private var configuration: Configuration?

	// MARK: - UI-Properties

	lazy private var field = NSTextField()
}

// MARK: - Tabletem
extension TextCell: ConfigurableView {

	typealias Configuration = TextItem

	static var reuseIdentifier: String = "textcell"

	convenience init(_ configuration: TextItem) {
		self.init(frame: .zero)
		configureUserInterface()
		configureConstraints()
		updateUserInterface(configuration)
	}

	func configure(_ configuration: TextItem) {
		updateUserInterface(configuration)
	}
}

// MARK: - Helpers
private extension TextCell {

	func configureUserInterface() {
		field.isBezeled = false
		field.isBordered = false
		field.drawsBackground = false
		field.usesSingleLineMode = true
		field.target = self
		field.action = #selector(cellDidChange(_:))
	}

	func updateUserInterface(_ configuration: Configuration) {
		self.configuration = configuration

		field.stringValue = configuration.text
		field.placeholderString = configuration.placeholder
		field.isEditable = configuration.action != nil
		field.textColor = configuration.textColor
		field.font = NSFont.preferredFont(forTextStyle: configuration.font)
		field.alignment = configuration.alignment
	}

	func configureConstraints() {
		addSubviews([field])

		field.constraint(.leading, to: .leading, inView: self, withOffset: .small)
		field.constraint(.trailing, to: .trailing, inView: self, withOffset: .minusSmall)
		field.constraint(.centerY, to: .centerY, inView: self)
	}
}

// MARK: - Actions
extension TextCell {

	@objc
	func cellDidChange(_ sender: NSTextField) {
		guard sender === field else {
			return
		}
		configuration?.action?(sender.stringValue)
	}
}
