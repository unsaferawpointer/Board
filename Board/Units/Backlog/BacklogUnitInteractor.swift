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
}

// MARK: - DataObserver
extension BacklogUnitInteractor: DataObserver {

	func providerDidChange(_ items: [TaskItem]) {
		presenter?.present(items)
	}
}
