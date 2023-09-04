//
//  BacklogView.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Foundation

protocol BacklogView: AnyObject {

	func display(_ models: [BacklogRowModel])
}
