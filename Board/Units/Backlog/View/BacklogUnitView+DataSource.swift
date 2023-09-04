//
//  BacklogUnitView+DataSource.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

// MARK: - NSTableViewDataSource
extension BacklogUnitView: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return models.count
	}
}
