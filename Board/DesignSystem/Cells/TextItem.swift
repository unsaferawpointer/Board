//
//  TextItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

/// View-model of text cell
struct TextItem {

	var text: String

	var font: NSFont.TextStyle

	var textColor: NSColor

	var placeholder: String?

	var alignment: NSTextAlignment

	var action: ((String) -> Void)?

	// MARK: - Initialization

	init(
		text: String,
		font: NSFont.TextStyle = .body,
		textColor: NSColor = .controlTextColor,
		placeholder: String? = nil,
		alignment: NSTextAlignment = .natural,
		action: ((String) -> Void)? = nil
	) {
		self.text = text
		self.font = font
		self.textColor = textColor
		self.placeholder = placeholder
		self.alignment = alignment
		self.action = action
	}

}

// MARK: - ViewConfiguration
extension TextItem: ViewConfiguration {

	typealias View = TextCell
}

// MARK: - Equatable
extension TextItem: Equatable {

	static func == (lhs: TextItem, rhs: TextItem) -> Bool {
		return lhs.text == rhs.text
		&& lhs.font == rhs.font
		&& lhs.textColor == rhs.textColor
		&& lhs.placeholder == rhs.placeholder
		&& lhs.alignment == rhs.alignment
	}
}
