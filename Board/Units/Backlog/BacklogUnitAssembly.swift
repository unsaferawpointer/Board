//
//  BacklogUnitAssembly.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

final class BacklogUnitAssembly {

	/// - Returns: Unit view controller
	static func build(stateProvider: StateProvider) -> NSViewController {
		let presenter = BacklogUnitPresenter(stateProvider: stateProvider)
		return BacklogUnitView { viewController in
			presenter.view = viewController
			viewController.output = presenter
		}
	}
}
