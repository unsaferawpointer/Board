//
//  DataObserver.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

protocol DataObserver: AnyObject {

	func providerDidChange(_ items: [TaskItem])
}
