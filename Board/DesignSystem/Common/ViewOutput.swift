//
//  ViewOutput.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

protocol ViewOutput {

	/// ViewController did change life-cycle state
	///
	/// - Parameters:
	///    - newState: New life-cycle state of the view-controller
	func viewControllerDidChangeState(_ newState: ViewControllerState)
}

enum ViewControllerState {
	case viewDidLoad
}
