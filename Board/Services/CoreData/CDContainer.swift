//
//  PersistentContainer.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation
import CoreData

/// CoreData persistent container
protocol CDContainerProtocol {
	/// Main managed object context
	var сontext: NSManagedObjectContext { get }
}

/// CoreData persistent container
final class CDContainer {

	static var shared: CDContainer = {
		let container = CDContainer()
		return container
	}()

	private var persistentContainer: NSPersistentContainer

	private init() {
		self.persistentContainer = {
			let container = NSPersistentCloudKitContainer(name: "Board")
			container.loadPersistentStores(completionHandler: { _, _ in })
			return container
		}()
	}
}

// MARK: - CDContainerProtocol
extension CDContainer: CDContainerProtocol {

	var сontext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
}
