//
//  NavigationUnitPresenterTests.swift
//  BoardTests
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import XCTest
@testable import Board

final class NavigationUnitPresenterTests: XCTestCase {

	var sut: NavigationUnitPresenter!

	var stateProvider: StateProviderMock!

	var view: NavigationViewMock!

	override func setUpWithError() throws {
		stateProvider = StateProviderMock()
		view = NavigationViewMock()
		sut = NavigationUnitPresenter(stateProvider: stateProvider)
		sut.view = view
	}

	override func tearDownWithError() throws {
		sut = nil
		stateProvider = nil
		view = nil
	}
}

// MARK: - Common test-cases
extension NavigationUnitPresenterTests {

	func test_viewControllerDidChangeState_whenStateIsViewDidLoad() {
		// Arrange
		stateProvider.stubs.state = .init(navigation: .board)

		// Act
		sut.viewControllerDidChangeState(.viewDidLoad)

		// Assert
		guard case let .display(labels) = view.invocations[0] else {
			return XCTFail("`display` should bew invocked" )
		}

		XCTAssertEqual(labels.count, 2)

		guard case let .select(selected) = view.invocations[1] else {
			return XCTFail("`display` should bew invocked" )
		}

		XCTAssertEqual(selected, .board)
	}

	func test_selectNavigationItem() throws {
		// Arrange
		stateProvider.stubs.state = .init(navigation: .board)

		sut.viewControllerDidChangeState(.viewDidLoad)

		guard case let .display(labels) = view.invocations[0] else {
			return XCTFail("`display` should bew invocked" )
		}

		XCTAssertEqual(labels.count, 2)

		let label = try XCTUnwrap(labels.first)

		// Act
		label.selected?()

		// Assert
		guard case let .setNavigation(item) = stateProvider.invocations.first else {
			return XCTFail("`setNavigation` should bew invocked" )
		}

		XCTAssertEqual(item, .backlog)
	}
}
