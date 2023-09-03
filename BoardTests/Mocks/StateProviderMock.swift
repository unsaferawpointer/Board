//
//  StateProviderMock.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation
@testable import Board

final class StateProviderMock {

	var invocations: [Action] = []

	var stubs = Stubs()
}

// MARK: - StateProvider
extension StateProviderMock: StateProvider {

	var state: AppState {
		return stubs.state
	}

	func addObserver(_ observer: AppStateObserver) {
		invocations.append(.addObserver(observer))
	}

	func setNavigation(_ item: NavigationItem) {
		invocations.append(.setNavigation(item))
	}
}

// MARK: - Nested data structs
extension StateProviderMock {

	enum Action {
		case addObserver(_ observer: AppStateObserver)
		case setNavigation(_ item: NavigationItem)
	}

	struct Stubs {
		var state: AppState = .init()
	}
}
