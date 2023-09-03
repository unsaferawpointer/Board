//
//  AppStateProvider.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

struct Observation {
	weak var observer: AppStateObserver?
}

// MARK: - StateProvider
final class AppStateProvider {

	// MARK: - Observation

	private var observations = [ObjectIdentifier: Observation]()

	private var _state: AppState

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - initialState: Initial state of the app
	init(initialState: AppState = .init()) {
		self._state = initialState
	}
}

// MARK: - StateProvider
extension AppStateProvider: StateProvider {

	/// Returns current state
	var state: AppState {
		get {
			_state
		}
		set {
			_state = newValue
		}
	}

	func addObserver(_ observer: AppStateObserver) {
		let id = ObjectIdentifier(observer)
		observations[id] = Observation(observer: observer)
	}

	func setNavigation(_ item: NavigationItem) {
		modificate(keyPath: \.navigation, newValue: item)
	}
}

// MARK: - Helpers
private extension AppStateProvider {

	func modificate(_ block: (inout AppState) -> Void) {
		block(&state)
		for (id, observation) in observations {
			guard let observer = observation.observer else {
				observations.removeValue(forKey: id)
				continue
			}
			observer.providerDidChangeState(state)
		}
	}

	func modificate<T>(keyPath: WritableKeyPath<AppState, T>, newValue: T) where T : Equatable {
		modificate { state in
			state[keyPath: keyPath] = newValue
		}
	}
}
