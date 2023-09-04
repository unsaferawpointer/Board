//
//  BacklogItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

struct BacklogItem {

	var uuid: UUID

	var creationDate: Date

	var text: String

	var estimation: Int

	var isUrgent: Bool

	// MARK: - Initialization

	init(
		uuid: UUID,
		creationDate: Date = Date(),
		text: String,
		estimation: Int = 0,
		isUrgent: Bool = false
	) {
		self.uuid = uuid
		self.creationDate = creationDate
		self.text = text
		self.estimation = estimation
		self.isUrgent = isUrgent
	}
}
