//
//  LabelView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

final class LabelView: NSTableCellView, ConfigurableView {

	static var reuseIdentifier: String = "label"

	typealias Configuration = LabelConfig

	private var configuration: Configuration {
		didSet {
			updateUserInterface()
		}
	}

	// MARK: - ConfigurableField

	init(_ configuration: Configuration) {
		self.configuration = configuration
		super.init(frame: .zero)
		configureConstraints()
		configureUserInterface()
		updateUserInterface()
	}

	func configure(_ configuration: Configuration) {
		self.configuration = configuration
	}

	@available(*, unavailable, message: "Use init(_:)")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - NSView life-cycle

	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

// MARK: - Helpers
private extension LabelView {

	func updateUserInterface() {
		textField?.stringValue = configuration.title
		imageView?.image = NSImage(systemSymbolName: configuration.iconName ?? "star.fill", accessibilityDescription: nil)
	}

	func configureUserInterface() {
		let textfield: NSTextField = {
			let view = NSTextField()
			view.focusRingType = .default
			view.cell?.sendsActionOnEndEditing = true
			view.isBordered = false
			view.drawsBackground = false
			view.usesSingleLineMode = true
			view.lineBreakMode = .byTruncatingMiddle
			return view
		}()

		self.textField = textfield
		self.addSubview(textfield)

		let imageView = NSImageView()
		self.imageView = imageView
		self.addSubview(imageView)
	}

	func configureConstraints() {
		guard
			let imageView = imageView,
			let textField = textField
		else {
			return
		}

		textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
		textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

		[imageView, textField].compactMap { $0 }.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		[
			imageView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor),

			textField.lastBaselineAnchor.constraint(equalTo: imageView.lastBaselineAnchor),
			textField.leadingAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 16),
			textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
		]
			.forEach { $0.isActive = true }
	}
}
