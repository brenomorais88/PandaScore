//
//  MatchDetailViewModelTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import XCTest
import Combine
@testable import PandaScoreApp

final class MatchDetailViewModelTests: XCTestCase {
    var viewData: MatchDetailViewData!
    var viewModel: MatchDetailViewModel!
    var mockService: MockMatchDetailService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockMatchDetailService()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockService = nil
        viewData = nil
        super.tearDown()
    }

    func test_load_viewData() {
        viewData = MatchDetailViewData.mock(title: "Custom title")
        viewModel = MatchDetailViewModel(service: mockService, viewData: viewData)

        let loadExpectation = expectation(description: "shoud load view data successfully")

        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.viewData.viewTitle, self.viewData.viewTitle)
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)
    }

    func test_load_details() {
        viewData = MatchDetailViewData.mock()
        viewModel = MatchDetailViewModel(service: mockService, viewData: viewData)

        let expectedPlayers1 = [
            MatchDetail.mock(id: 1),
            MatchDetail.mock(id: 2)
        ]

        let expectedPlayers2 = [
            MatchDetail.mock(id: 3),
            MatchDetail.mock(id: 4)
        ]

        mockService.fetchResult = [.success(expectedPlayers1), .success(expectedPlayers2)]

        let loadExpectation = expectation(description: "shoud load data successfully")
        viewModel.loadDetail()

        DispatchQueue.main.async {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.t1players, expectedPlayers1)
            XCTAssertEqual(self.viewModel.t2players, expectedPlayers2)
            loadExpectation.fulfill()
        }
        wait(for: [loadExpectation], timeout: 1.0)
    }
}
