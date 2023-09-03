//
//  AppCoordinator.swift
//  Board
//
//  Created by Anton Cherkasov on 02.09.2023.
//

/// Interface of the coordinator
protocol Coordinatable {

	/// Start flow
	func start()
}

/// App coordinator
final class AppCoordinator {

	private (set) var router: Routable

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
		let sidebar = ViewController()
		let detail = ViewController()
		router.showWindowAndOrderFront(
			sidebar: sidebar,
			detail: detail
		)
	}
}
