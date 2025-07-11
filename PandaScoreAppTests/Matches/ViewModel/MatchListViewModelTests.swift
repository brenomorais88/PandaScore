//
//  MatchListViewModelTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import XCTest
import Combine
@testable import PandaScoreApp

final class MatchListViewModelTests: XCTestCase {
    var viewModel: MatchListViewModel!
    var mockService: MockMatchService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockMatchService()
        viewModel = MatchListViewModel(service: mockService)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func test_fetchMatches_success_should_append_matches() {
        // Given
        let matches = [Match.mock(id: 1), Match.mock(id: 2)]
        mockService.fetchResult = .success(matches)

        let expectation = XCTestExpectation(description: "fetch matches")

        viewModel.$matches
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // When
        viewModel.fetchMatches()

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func test_fetchMatches_cant_load_more() {
        let matches = [Match.mock(id: 1), Match.mock(id: 2)]
        mockService.fetchResult = .success(matches)

        let expectation = XCTestExpectation(description: "Can't load more remains true")

        viewModel.fetchMatches()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.viewModel.canLoadMore)
            XCTAssertEqual(self.viewModel.matches.count, 2)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchMatches_can_load_more() {
        var matches: [Match] = []
        for i in 0..<20 {
            matches.append(Match.mock(id: i))
        }
        mockService.fetchResult = .success(matches)

        let expectation = XCTestExpectation(description: "Can load more remains true")

        viewModel.fetchMatches()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.viewModel.canLoadMore)
            XCTAssertEqual(self.viewModel.matches.count, 20)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchMatches_withReset_should_clear_matches() {
        let expectation = XCTestExpectation(description: "Can reset matches data")

        viewModel.matches = [Match.mock(id: 98), Match.mock(id: 99), Match.mock(id: 100)]

        let newMatches = [Match.mock(id: 1), Match.mock(id: 2)]

        mockService.fetchResult = .success(newMatches)
        viewModel.fetchMatches(reset: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.matches.count, 2)
            XCTAssertEqual(self.viewModel.matches.map(\.id), [1, 2])
            XCTAssertFalse(self.viewModel.canLoadMore)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchMatches_whenIsLoading_shouldNotFetch() {
        viewModel.isLoading = true
        viewModel.canLoadMore = true

        viewModel.fetchMatches()

        XCTAssertEqual(mockService.callCount, 0)
    }

    func test_fetchMatches_when_canLoadMoreIsFalse_shouldNotFetch() {
        viewModel.isLoading = false
        viewModel.canLoadMore = false

        viewModel.fetchMatches()

        XCTAssertEqual(mockService.callCount, 0)
    }
}
