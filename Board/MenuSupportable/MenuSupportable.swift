//
//  MenuSupportable.swift
//  Board
//
//  Created by Anton Cherkasov on 25.09.2023.
//

import Cocoa

@objc
protocol MenuSupportable {

	@objc
	optional func createNew()

	@objc
	optional func delete()

	@objc
	optional func setEstimation(_ sender: NSMenuItem)

	@objc
	optional func markAsUrgent()

	@objc
	optional func markAsNonUrgent()

	@objc
	optional func quit()
}
