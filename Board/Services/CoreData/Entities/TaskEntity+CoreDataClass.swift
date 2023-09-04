//
//  TaskEntity+CoreDataClass.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//
//

import Foundation
import CoreData

@objc(TaskEntity)
public final class TaskEntity: NSManagedObject {

	public override func awakeFromInsert() {
		super.awakeFromInsert()
		self.uuid = UUID()
		self.text = ""
		self.isUrgent = false
		self.creationDate = Date()
		self.planningDate = nil
		self.beginngDate = nil
		self.completionDate = nil
		self.estimation = 0
	}
}

// MARK: - ItemRepresentable
extension TaskEntity: ItemRepresentable {

	typealias Item = TaskItem

	var item: TaskItem {
		return .init(
			uuid: uuid,
			creationDate: creationDate,
			planningDate: planningDate,
			beginngDate: beginngDate,
			completionDate: completionDate,
			text: text,
			estimation: Int(estimation),
			isUrgent: isUrgent
		)
	}

	func update(by item: TaskItem) {
		self.uuid = item.uuid
		self.text = item.text
		self.isUrgent = item.isUrgent
		self.creationDate = item.creationDate
		self.planningDate = item.planningDate
		self.beginngDate = item.beginngDate
		self.completionDate = item.completionDate
		self.estimation = Int16(item.estimation)
	}

	convenience init(from item: TaskItem, context: NSManagedObjectContext) {
		self.init(context: context)
		update(by: item)
	}
}
