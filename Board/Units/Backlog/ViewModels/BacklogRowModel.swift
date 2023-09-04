//
//  BacklogRowModel.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

struct BacklogRowModel: Equatable {

	var id: UUID

	var description: String

	var estimation: String

	var isUrgent: Bool
}
