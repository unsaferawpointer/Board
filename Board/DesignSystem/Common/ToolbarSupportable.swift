//
//  ToolbarSupportable.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Cocoa

protocol ToolbarSupportable {
	func makeToolbarItems() -> [NSToolbarItem]
}
