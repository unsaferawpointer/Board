//
//  BacklogViewMock.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 04.09.2023.
//

@testable import Board

final class BacklogViewMock {

	var invocations: [Action] = []
}

// MARK: - BacklogView
extension BacklogViewMock: BacklogView {

	func display(_ models: [BacklogRowModel]) {
		invocations.append(.display(models))
	}
}

// MARK: - Nested data structs
extension BacklogViewMock {

	enum Action: Equatable {
		case display(_ models: [BacklogRowModel])
	}
}
