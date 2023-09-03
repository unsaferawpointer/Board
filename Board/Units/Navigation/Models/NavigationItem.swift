//
//  NavigationItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

enum NavigationItem {
	case backlog
	case board
}

// MARK: - Hashable
extension NavigationItem: Hashable { }
