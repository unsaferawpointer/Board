//
//  Array+Extension.swift
//  Board
//
//  Created by Anton Cherkasov on 26.09.2023.
//

import Foundation

extension Array {

	/// - Warning: unsafe casting
	func sorted(using sorting: [NSSortDescriptor]) -> [Element] {
		return (self as NSArray).sortedArray(using: sorting) as! [Element]
	}
}
