//
//  MatchListViewTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

// MatchListViewTests.swift

import XCTest
import SwiftUI
import ViewInspector
@testable import PandaScoreApp

// MARK: - Spy ViewModel
final class SpyMatchListViewModel: MatchListViewModel {
    private(set) var fetchCalled = false
    private(set) var refreshCalled = false

    init() {
        let service = MockMatchService()
        super.init(service: service)
    }

    override func fetchMatches(reset: Bool = false) {
        fetchCalled = true
    }

    override func refresh() {
        refreshCalled = true
    }
}

final class MatchListViewTests: XCTestCase {

    // MARK: - Empty State

    func test_emptyState_showsEmptyDataText() throws {
        let vm = SpyMatchListViewModel()
        vm.matches = []
        vm.isLoading = false

        let view = MatchListView(viewModel: vm)
        let text = try view.inspect().find(text: LocalizedStrings.MatchList.emptyData)
        XCTAssertEqual(try text.string(), LocalizedStrings.MatchList.emptyData)
    }

    func test_emptyState_loadingTrue_showsFullScreenProgressView() throws {
        let vm = SpyMatchListViewModel()
        vm.matches = []
        vm.isLoading = true

        let view = MatchListView(viewModel: vm)
        let progress = try view.inspect().find(ViewType.ProgressView.self)
        XCTAssertEqual(try progress.scaleEffect(), CGSize(width: 2.0, height: 2.0))
    }

    // MARK: - Data State & Bottom Loading Indicator

    func test_withMatches_showsScrollView_andMatchRows() throws {
        let sample = Match.mock(id: 42)
        let vm = SpyMatchListViewModel()
        vm.matches = [sample]
        vm.isLoading = false

        let view = MatchListView(viewModel: vm)
        let scroll = try view.inspect().find(ViewType.ScrollView.self)

        let forEach = try scroll.lazyVStack().find(ViewType.ForEach.self)

        XCTAssertNoThrow( try forEach.view(MatchRow.self, 0) )
    }

    func test_withMatches_andIsLoadingTrue_showsBottomLoadingIndicator() throws {
        let sample = Match.mock(id: 99)
        let vm = SpyMatchListViewModel()
        vm.matches = [sample]
        vm.isLoading = true

        let view = MatchListView(viewModel: vm)
        let loadingText = try view.inspect().find(text: LocalizedStrings.MatchList.loading)
        XCTAssertEqual(try loadingText.string(), LocalizedStrings.MatchList.loading)
    }

    // MARK: - Toolbar Title

    func test_toolbar_showsCorrectTitle() throws {
        let vm = SpyMatchListViewModel()
        let view = MatchListView(viewModel: vm)
        let titleText = try view.inspect().find(text: LocalizedStrings.MatchList.title)
        XCTAssertEqual(try titleText.string(), LocalizedStrings.MatchList.title)
    }

    // MARK: - onAppear and Pull-to-Refresh

    func test_onAppear_callsFetchMatches() throws {
        let vm = SpyMatchListViewModel()
        let view = MatchListView(viewModel: vm)

        try view.inspect().group().callOnAppear()
        XCTAssertTrue(vm.fetchCalled)
    }

    // MARK: - Pagination (last row onAppear)

    func test_onLastRowAppear_triggersFetchMatchesAgain() throws {
        let sample1 = Match.mock(id: 1)
        let sample2 = Match.mock(id: 2)
        let vm = SpyMatchListViewModel()
        vm.matches = [sample1, sample2]

        let view = MatchListView(viewModel: vm)
        let rows = try view.inspect().findAll(MatchRow.self)
        let lastRow = rows.last!
        try lastRow.callOnAppear()
        XCTAssertTrue(vm.fetchCalled)
    }
}
