//
//  DataStorage.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

protocol DataStorage {

	func save() throws
	
	func insertTask(_ item: TaskItem)
	
	func deleteTasks(_ ids: [UUID]) throws
	
	func updateTasks(withIds ids: [UUID], _ block: (inout TaskItem) -> Void) throws
}
