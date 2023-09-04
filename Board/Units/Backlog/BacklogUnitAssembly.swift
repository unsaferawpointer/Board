//
//  BacklogUnitAssembly.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

final class BacklogUnitAssembly {

	/// - Returns: Unit view controller
	static func build(
		stateProvider: StateProvider,
		dataProvider: DataProvider,
		dataStorage: DataStorage
	) -> NSViewController {
		let interactor = BacklogUnitInteractor(dataProvider: dataProvider, dataStorage: dataStorage)
		let presenter = BacklogUnitPresenter(stateProvider: stateProvider)
		presenter.interactor = interactor
		interactor.presenter = presenter
		return BacklogUnitView { viewController in
			presenter.view = viewController
			viewController.output = presenter
		}
	}
}
