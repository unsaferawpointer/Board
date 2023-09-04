//
//  String+Extension.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import Foundation

extension String {

	static var random: String {
		return UUID().uuidString
	}
}
