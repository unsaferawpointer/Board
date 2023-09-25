//
//  AppCoordinator.swift
//  Board
//
//  Created by Anton Cherkasov on 02.09.2023.
//

import Cocoa

/// Interface of the coordinator
protocol Coordinatable {

	/// Start flow
	func start()
}

/// App coordinator
final class AppCoordinator {

	private (set) var router: Routable

	private (set) var stateProvider = AppStateProvider()

	private (set) var dataProvider = CDProvider(context: CDContainer.shared.сontext)

	private (set) var dataStorage = CDStorage(context: CDContainer.shared.сontext)

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - router: App router
	init(router: Routable = AppRouter()) {
		self.router = router
	}
}

// MARK: - Coordinatable
extension AppCoordinator: Coordinatable {

	func start() {
		let sidebar = NavigationUnitAssembly.build(stateProvider: stateProvider)
		let detail = presentedDetailController(for: stateProvider.state.navigation)
		router.showWindowAndOrderFront(sidebar: sidebar, detail: detail)
		stateProvider.addObserver(self)
	}
}

// MARK: - Helpers
private extension AppCoordinator {

	func presentedDetailController(for item: NavigationItem) -> NSViewController {
		switch item {
		case .backlog:
			return BacklogUnitAssembly.build(
				stateProvider: stateProvider,
				dataProvider: dataProvider,
				dataStorage: dataStorage
			)
		case .board:
			return BoardUnitView({ _ in })
		}
	}
}

// MARK: - StateObserver
extension AppCoordinator: AppStateObserver {

	func providerDidChangeState(_ newState: AppState) {
		let detail = presentedDetailController(for: newState.navigation)
		router.presentDetail(detail)
	}
}
