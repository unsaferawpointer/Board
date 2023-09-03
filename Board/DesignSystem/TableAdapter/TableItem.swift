//
//  TableItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

/// Table row configuration interface
protocol TableItem: ViewConfiguration, Hashable, Identifiable {

	static var reuseIdentifier: String { get }
}

// MARK: - Implementing the Hashable Protocol
extension TableItem {

	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
