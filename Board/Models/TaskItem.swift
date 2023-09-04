//
//  TaskItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

struct TaskItem {

	var uuid: UUID

	var creationDate: Date

	var planningDate: Date?

	var beginngDate: Date?

	var completionDate: Date?

	var text: String

	var estimation: Int

	var isUrgent: Bool

	// MARK: - Initialization

	init(
		uuid: UUID,
		creationDate: Date = Date(),
		planningDate: Date? = nil,
		beginngDate: Date? = nil,
		completionDate: Date? = nil,
		text: String,
		estimation: Int = 0,
		isUrgent: Bool = false
	) {
		self.uuid = uuid
		self.creationDate = creationDate
		self.planningDate = planningDate
		self.beginngDate = beginngDate
		self.completionDate = completionDate
		self.text = text
		self.estimation = estimation
		self.isUrgent = isUrgent
	}
}
