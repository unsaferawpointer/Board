//
//  BacklogRowModel.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

final class BacklogRowModel: NSObject {

	var id: UUID
	
	@objc
	var timestamp: Date

	@objc
	var text: String

	@objc
	var estimation: String

	@objc
	var isUrgent: Bool
	
	init(
		id: UUID,
		timestamp: Date,
		text: String,
		estimation: String,
		isUrgent: Bool
	) {
		self.id = id
		self.timestamp = timestamp
		self.text = text
		self.estimation = estimation
		self.isUrgent = isUrgent
		super.init()
	}
}
