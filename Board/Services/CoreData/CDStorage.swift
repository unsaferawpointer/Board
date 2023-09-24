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

	func deleteTasks(_ ids: [UUID]) throws {
		for id in ids {
			guard let entity = try fetchEntity(ofType: TaskEntity.self, withIdentifier: id) else {
				continue
			}
			context.delete(entity)
		}
	}

	func updateTasks(withIds ids: [UUID], _ block: (inout TaskItem) -> Void) throws {
		for id in ids {
			guard let entity = try fetchEntity(ofType: TaskEntity.self, withIdentifier: id) else {
				continue
			}
			var item = entity.item
			block(&item)
			entity.update(by: item)
		}
	}

	// MARK: - Common

	func save() throws {
		guard context.hasChanges else {
			return
		}
		try context.save()
	}
}

extension CDStorage {

	func fetchEntity<T: NSManagedObject>(ofType type: T.Type, withIdentifier id: UUID) throws -> T? {
		let request = type.fetchRequest()
		request.predicate = NSPredicate(format: "uuid == %@", argumentArray: [id])
		request.fetchLimit = 1
		let entities = try context.fetch(request)
		return entities.first as? T
	}
}
