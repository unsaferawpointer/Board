//
//  TaskEntity+CoreDataProperties.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//
//

import Foundation
import CoreData

extension TaskEntity {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
		return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
	}

	@NSManaged public var uuid: UUID
	@NSManaged public var text: String
	@NSManaged public var isUrgent: Bool
	@NSManaged public var creationDate: Date
	@NSManaged public var planningDate: Date?
	@NSManaged public var beginngDate: Date?
	@NSManaged public var completionDate: Date?
	@NSManaged public var estimation: Int16

}

// MARK: - Identifiable
extension TaskEntity : Identifiable { }
