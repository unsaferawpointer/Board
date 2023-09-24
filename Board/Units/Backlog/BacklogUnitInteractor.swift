//
//  BacklogUnitInteractor.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

/// Backlog interactor interface
protocol BacklogInteractor {

	/// Fetch data
	func invalidateData()
	
	func createTask(withText text: String)
	
	func deleteTasks(_ ids: [UUID])
	
	func setUrgentFlag(_ flag: Bool, forTasks ids: [UUID])
	
	func setEstimation(_ estimation: Int, forTasks ids: [UUID])
	
	func setText(_ text: String, forTask id: UUID)
}

final class BacklogUnitInteractor {

	weak var presenter: BacklogPresenter?

	var dataProvider: DataProvider

	var dataStorage: DataStorage

	// MARK: - Initialization

	init(dataProvider: DataProvider, dataStorage: DataStorage) {
		self.dataProvider = dataProvider
		self.dataStorage = dataStorage
	}
}

// MARK: - BacklogInteractor
extension BacklogUnitInteractor: BacklogInteractor {

	func invalidateData() {
		dataProvider.addObserver(self)
	}
	
	func createTask(withText text: String) {
		let new = TaskItem(text: text)
		dataStorage.insertTask(new)
		try? dataStorage.save()
	}

	func deleteTasks(_ ids: [UUID]) {
		try? dataStorage.deleteTasks(ids)
		try? dataStorage.save()
	}

	func setUrgentFlag(_ flag: Bool, forTasks ids: [UUID]) {
		try? dataStorage.updateTasks(withIds: ids) { item in
			item.isUrgent = flag
		}
		try? dataStorage.save()
	}
	
	func setEstimation(_ estimation: Int, forTasks ids: [UUID]) {
		try? dataStorage.updateTasks(withIds: ids) { item in
			item.estimation = estimation
		}
		try? dataStorage.save()
	}
	
	func setText(_ text: String, forTask id: UUID) {
		try? dataStorage.updateTasks(withIds: [id]) { item in
			item.text = text
		}
		try? dataStorage.save()
	}
}

// MARK: - DataObserver
extension BacklogUnitInteractor: DataObserver {

	func providerDidChange(_ items: [TaskItem]) {
		presenter?.present(items)
	}
}
