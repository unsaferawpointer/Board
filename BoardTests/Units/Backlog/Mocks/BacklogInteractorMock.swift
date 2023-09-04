//
//  BacklogInteractorMock.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 04.09.2023.
//

@testable import Board

final class BacklogInteractorMock {

	var invocations: [Action] = []

	var stubs = Stubs()

	var errors = ErrorStubs()
}

// MARK: - BacklogInteractor
extension BacklogInteractorMock: BacklogInteractor {

	func fetchData(completionHandler: ([BacklogItem]) -> Void) throws {
		if let error = errors.fetchData {
			throw error
		}
		completionHandler(stubs.fetchData)
	}
}

// MARK: - Nested data structs
extension BacklogInteractorMock {

	enum Action: Equatable {
		case display(_ models: [BacklogRowModel])
	}

	struct Stubs {
		var fetchData: [BacklogItem] = []
	}

	struct ErrorStubs {
		var fetchData: Error?
	}
}
