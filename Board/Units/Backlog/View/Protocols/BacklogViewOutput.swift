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
}
