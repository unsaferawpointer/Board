//
//  NavigationViewMock.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation
@testable import Board

final class NavigationViewMock {

	var invocations: [Action] = []
}

// MARK: - NavigationView
extension NavigationViewMock: NavigationView {

	func display(_ labels: [LabelConfig]) {
		invocations.append(.display(labels))
	}

	func select(_ item: NavigationItem) {
		invocations.append(.select(item))
	}
}

// MARK: - Nested data structs
extension NavigationViewMock {

	enum Action: Equatable {
		case display(_ labels: [LabelConfig])
		case select(_ item: NavigationItem)
	}
}
