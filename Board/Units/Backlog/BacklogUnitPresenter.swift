//
//  BacklogUnitPresenter.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

protocol BacklogPresenter: AnyObject {

	func present(_ items: [TaskItem])
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

	func present(_ items: [TaskItem]) {
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
		interactor.invalidateData()
	}

	func fieldDidChange(description: String, forId id: UUID) {
		interactor?.setText(description, forTask: id)
	}

	func fieldDidChange(urgentFlag: Bool, forId id: UUID) {
		interactor?.setUrgentFlag(urgentFlag, forTasks: [id])
	}
	
	func buttonToCreateHasBeenClicked() {
		interactor?.createTask(withText: "New Task")
	}

	func menuItemToDeleteHasBeenClicked(for ids: [UUID]) {
		interactor?.deleteTasks(ids)
	}
	
	func menuItemToMarkUrgentHasBeenClicked(for ids: [UUID]) {
		interactor?.setUrgentFlag(true, forTasks: ids)
	}
	
	func menuItemToMarkNonUrgentHasBeenClicked(for ids: [UUID]) {
		interactor?.setUrgentFlag(false, forTasks: ids)
	}
	
	func menuItemToSetEstimationHasBeenClicked(estimation: Int, for ids: [UUID]) {
		interactor?.setEstimation(estimation, forTasks: ids)
	}
}

// MARK: - Helpers
private extension BacklogUnitPresenter {

	func makeModels(from items: [TaskItem]) -> [BacklogRowModel] {
		return items.map {
			BacklogRowModel(
				id: $0.uuid, 
				timestamp: $0.creationDate,
				text: $0.text,
				estimation: $0.estimation != 0 ? "\($0.estimation) sp": "",
				isUrgent: $0.isUrgent
			)
		}
	}
}
