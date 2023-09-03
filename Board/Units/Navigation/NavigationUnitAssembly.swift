//
//  NavigationAssembly.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

final class NavigationUnitAssembly {

	/// - Returns: Unit view controller
	static func build(stateProvider: StateProvider) -> NSViewController {
		let presenter = NavigationUnitPresenter(stateProvider: stateProvider)
		return NavigationUnitView { viewController in
			presenter.view = viewController
			viewController.output = presenter
		}
	}
}
