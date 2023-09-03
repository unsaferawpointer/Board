//
//  StateProvider.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

/// App stte provider interface
protocol StateProvider {

	/// Returns current state
	var state: AppState { get }

	/// Add data observation
	func addObserver(_ observer: AppStateObserver)

	func setNavigation(_ item: NavigationItem)
}

protocol AppStateObserver: AnyObject {

	func providerDidChangeState(_ newState: AppState)
}
