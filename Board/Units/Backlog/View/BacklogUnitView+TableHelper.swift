//
//  BacklogUnitView+TableHelper.swift
//  Board
//
//  Created by Anton Cherkasov on 26.09.2023.
//

import Foundation

extension BacklogUnitView {

	func reloadTable(_ new: [BacklogRowModel]) {

		let identifiers = table.selectedRowIndexes.map { row in
			models[row].id
		}

		self.models = new.sorted(using: table.sortDescriptors)

		table.reloadData()

		var cache = [AnyHashable: Int]()
		for (index, model) in models.enumerated() {
			cache[model.id] = index
		}

		let rows = identifiers.compactMap { id in
			cache[id]
		}

		table.selectRowIndexes(IndexSet(rows), byExtendingSelection: false)
	}
}
