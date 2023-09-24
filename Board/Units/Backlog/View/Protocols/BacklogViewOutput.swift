//
//  BacklogViewOutput.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

protocol BacklogViewOutput: ViewOutput {

	func fieldDidChange(description: String, forId id: UUID)

	func fieldDidChange(urgentFlag: Bool, forId id: UUID)
	
	func buttonToCreateHasBeenClicked()
	
	func menuItemToDeleteHasBeenClicked(for ids: [UUID])
	
	func menuItemToMarkUrgentHasBeenClicked(for ids: [UUID])
	
	func menuItemToMarkNonUrgentHasBeenClicked(for ids: [UUID])
	
	func menuItemToSetEstimationHasBeenClicked(estimation: Int, for ids: [UUID])
}
