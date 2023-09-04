//
//  NSImage+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Cocoa

extension NSImage {

	convenience init?(symbolName: String?) {
		guard let symbolName else {
			return nil
		}
		self.init(
			systemSymbolName: symbolName,
			accessibilityDescription: nil
		)
	}
}
