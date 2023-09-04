//
//  BacklogUnitPresenterTests.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 04.09.2023.
//

import XCTest
@testable import Board

final class BacklogUnitPresenterTests: XCTestCase {

	var sut: BacklogUnitPresenter!

	var stateProvider: StateProviderMock!

	var view: BacklogViewMock!

	var interactor: BacklogInteractorMock!

	override func setUpWithError() throws {
		stateProvider = StateProviderMock()
		interactor = BacklogInteractorMock()
		view = BacklogViewMock()
		sut = BacklogUnitPresenter(stateProvider: stateProvider)
		sut.view = view
		sut.interactor = interactor
	}

	override func tearDownWithError() throws {
		sut = nil
		stateProvider = nil
		view = nil
	}
}

// MARK: - BacklogViewOutput test-cases
extension BacklogUnitPresenterTests {

	func test_viewControllerDidChangeState_whenStateIsViewDidLoad() {
		// Arrange

		let item0 = TaskItem(uuid: .random, text: .random, estimation: 0, isUrgent: false)
		let item1 = TaskItem(uuid: .random, text: .random, estimation: 7, isUrgent: true)

		interactor.stubs.fetchData = [item0, item1]

		// Act
		sut.viewDidChangeState(.viewDidLoad)

		// Assert
		guard case let .display(models) = view.invocations[0] else {
			return XCTFail("`display` should bew invocked" )
		}

		XCTAssertEqual(models.count, 2)
	}
}

// MARK: - BacklogPresenter test-cases
extension BacklogUnitPresenterTests {

	func test_present() {
		// Arrange

		let item0 = TaskItem(uuid: .random, text: .random, estimation: 0, isUrgent: false)
		let item1 = TaskItem(uuid: .random, text: .random, estimation: 7, isUrgent: true)

		// Act
		sut.present([item0, item1])

		// Assert
		guard case let .display(models) = view.invocations[0] else {
			return XCTFail("`display` should bew invocked" )
		}

		XCTAssertEqual(models.count, 2)

		let model0 = models[0]

		XCTAssertEqual(model0.id, item0.uuid)
		XCTAssertEqual(model0.description, item0.text)
		XCTAssertEqual(model0.estimation, "")
		XCTAssertFalse(model0.isUrgent)

		let model1 = models[1]

		XCTAssertEqual(model1.id, item1.uuid)
		XCTAssertEqual(model1.description, item1.text)
		XCTAssertEqual(model1.estimation, "7 sp")
		XCTAssertTrue(model1.isUrgent)
	}
}
