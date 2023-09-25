//
//  BoardUnitView.swift
//  Board
//
//  Created by Anton Cherkasov on 25.09.2023.
//

import Cocoa

final class BoardUnitView: NSViewController {

	// MARK: - UI-Properties

	lazy var container: NSStackView = {
		let view = NSStackView(views: [NSView(), NSView(), NSView()])
		view.orientation = .horizontal
		view.distribution = .fillEqually
		return view
	}()

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - configure: Configuration closure. Setup unit here.
	init(_ configure: (BoardUnitView) -> Void) {
		super.init(nibName: nil, bundle: nil)
		configure(self)
		configureUserInterface()
	}

	@available(*, unavailable, message: "Use init()")
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Life-cycle

	override func loadView() {
		self.view = container
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - Helpers
private extension BoardUnitView {

	func configureUserInterface() { 
		// TODO: Handle method
	}
}
