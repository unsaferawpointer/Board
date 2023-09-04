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
	func fetchData(completionHandler: ([BacklogItem]) -> Void) throws
}
