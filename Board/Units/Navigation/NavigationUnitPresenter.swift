//
//  NavigationUnitPresenter.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

final class NavigationUnitPresenter {

	// MARK: - DI

	weak var view: NavigationView?

	private var stateProvider: StateProvider

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - stateProvider: App state provider
	init(stateProvider: StateProvider) {
		self.stateProvider = stateProvider
	}
}

// MARK: - ViewOutput
extension NavigationUnitPresenter: ViewOutput {

	func viewControllerDidChangeState(_ newState: ViewControllerState) {
		guard case .viewDidLoad = newState else {
			return
		}
		let labels = makeLabels()
		view?.display(labels)
		view?.select(stateProvider.state.navigation)
	}
}

// MARK: - Helpers
private extension NavigationUnitPresenter {

	func makeLabels() -> [LabelConfig] {
		let backlog = LabelConfig(id: .backlog, title: "Backlog", iconName: "square.3.layers.3d") { [weak self] in
			self?.stateProvider.setNavigation(.backlog)
		}
		let board = LabelConfig(id: .board, title: "Board", iconName: "rectangle.split.3x1.fill") { [weak self] in
			self?.stateProvider.setNavigation(.board)
		}
		return [backlog, board]
	}
}
