//
//  ToggleItem.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

/// Toggle view-model
struct ToggleItem {

	var isEnable: Bool

	var image: String

	var alternativeImage: String

	var tintColor: NSColor

	var action: ((Bool) -> Void)?
}

// MARK: - ViewConfiguration
extension ToggleItem: ViewConfiguration {

	typealias View = ToggleCell
}
