//
//  ViewController.swift
//  Board
//
//  Created by Anton Cherkasov on 02.09.2023.
//

import Cocoa

class ViewController: NSViewController {

	lazy var label: NSTextField = {
		let view = NSTextField()
		view.isEditable = false
		view.usesSingleLineMode = true
		return view
	}()

	// MARK: - Initialization

	init(text: String) {
		super.init(nibName: nil, bundle: nil)
		configureConstraints()
		label.stringValue = text
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = NSView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
}

extension ViewController {

	func configureConstraints() {

		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)

		NSLayoutConstraint.activate(
			[
				label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
				label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
			]
		)

	}
}
