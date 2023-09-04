//
//  DataProvider.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import CoreData

/// App data provider interface
protocol DataProvider {

	func addObserver(_ observer: DataObserver)
}
