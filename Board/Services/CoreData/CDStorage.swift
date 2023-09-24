//
//  CDStorage.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import CoreData

/// CoreData data provider
final class CDStorage {

	private var context: NSManagedObjectContext

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - context: Main managed object context
	init(context: NSManagedObjectContext) {
		self.context = context
	}
}

// MARK: - DataStorage
extension CDStorage: DataStorage {

	func insertTask(_ item: TaskItem) {
		_ = TaskEntity(from: item, context: context)
	}

	// MARK: - Common

	func save() throws {
		guard context.hasChanges else {
			return
		}
		try context.save()
	}
}
