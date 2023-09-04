//
//  BacklogUnitPresenter.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

protocol BacklogPresenter {

	func present(_ items: [BacklogItem])
}

final class BacklogUnitPresenter {

	// MARK: - DI

	weak var view: BacklogView?

	var interactor: BacklogInteractor?

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

// MARK: - BacklogPresenter
extension BacklogUnitPresenter: BacklogPresenter {

	func present(_ items: [BacklogItem]) {
		let models = makeModels(from: items)
		view?.display(models)
	}
}

// MARK: - ViewOutput
extension BacklogUnitPresenter: BacklogViewOutput {

	func viewDidChangeState(_ newState: ViewControllerState) {
		guard case .viewDidLoad = newState, let interactor else {
			return
		}
		do {
			try interactor.fetchData { [weak self] items in
				self?.present(items)
			}
		} catch {
			// TODO: - Handle errors
		}
	}

	func fieldDidChange(description: String, forId id: UUID) {
		// TODO: - Handle action
	}

	func fieldDidChange(urgentFlag: Bool, forId id: UUID) {
		// TODO: - Handle action
	}
}

// MARK: - Helpers
private extension BacklogUnitPresenter {

	func makeModels(from items: [BacklogItem]) -> [BacklogRowModel] {
		return items.map {
			BacklogRowModel(
				id: $0.uuid,
				description: $0.text,
				estimation: $0.estimation != 0 ? "\($0.estimation) sp": "",
				isUrgent: $0.isUrgent
			)
		}
	}
}
