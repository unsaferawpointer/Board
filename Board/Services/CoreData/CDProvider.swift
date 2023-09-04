//
//  CDDataProvider.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation
import CoreData

final class CDProvider {

	var observations: [ObjectIdentifier: Observation] = [:]

	private var context: NSManagedObjectContext

	// MARK: - Initialization

	/// Basic initialization
	///
	/// - Parameters:
	///    - context: Managed object context
	init(context: NSManagedObjectContext) {
		self.context = context
		configureNotification()
	}
}

// MARK: - DataProvider
extension CDProvider: DataProvider {

	func addObserver(_ observer: DataObserver) {
		let id = ObjectIdentifier(observer)
		observations[id] = Observation(observer: observer)
		notificate()
	}
}

// MARK: - Helpers
private extension CDProvider {

	func configureNotification() {
		NotificationCenter.default.addObserver(
			forName: .NSManagedObjectContextDidSave,
			object: context,
			queue: .main) { [weak self] _ in
				self?.notificate()
		}
	}

	func notificate() {
		let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
		let entities = try? context.fetch(request)
		let items = entities?.map(\.item)
		for (id, observation) in observations {
			guard let observer = observation.observer else {
				observations.removeValue(forKey: id)
				continue
			}
			observer.providerDidChange(items ?? [])
		}
	}
}

// MARK: - Nested data structs
extension CDProvider {

	struct Observation {

		weak var observer: DataObserver?

		init(observer: DataObserver) {
			self.observer = observer
		}
	}
}
