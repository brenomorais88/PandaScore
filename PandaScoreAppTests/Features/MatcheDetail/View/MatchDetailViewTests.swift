//
//  MatchDetailViewTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import PandaScoreApp

final class SpyMatchDetailViewModel: MatchDetailViewModel {
    private(set) var loadDetailCalled = false

    init(service: MatchDetailServiceProtocol = MockMatchDetailService()) {
        let viewData = MatchDetailViewData.mock()
        super.init(service: service, viewData: viewData)

        self.t1players = [MatchDetail.mock(id: 3), MatchDetail.mock(id: 4)]
        self.t2players = [MatchDetail.mock(id: 5), MatchDetail.mock(id: 6)]
    }

    override func loadDetail() {
        loadDetailCalled = true
    }
}

final class MatchDetailViewTests: XCTestCase {

    func test_loadDetail_called() throws {
        let spyVM = SpyMatchDetailViewModel()
        let sut = NavigationView {
            MatchDetailView(viewModel: spyVM)
        }

        let zstack = try sut.inspect()
            .navigationView()
            .view(MatchDetailView.self, 0)
            .zStack()
        try zstack.callOnAppear()

        XCTAssertTrue(spyVM.loadDetailCalled)
    }
    
    func test_load_state() throws {
        let spyVM = SpyMatchDetailViewModel()

        let sut = NavigationView {
            MatchDetailView(viewModel: spyVM)
        }

        let zstack = try sut.inspect()
            .navigationView()
            .view(MatchDetailView.self, 0)
            .zStack()
        try zstack.callOnAppear()

        XCTAssertEqual(zstack.findAll(TeamHeaderView.self).count, 1)
        XCTAssertEqual(zstack.findAll(PlayerRow.self).count, 2)
        XCTAssertEqual(zstack.findAll(ViewType.ProgressView.self).count, 0)
    }

    func test_loading_state() throws {
        let spyVM = SpyMatchDetailViewModel()
        spyVM.isLoading = true

        let sut = NavigationView {
            MatchDetailView(viewModel: spyVM)
        }

        let zstack = try sut.inspect()
            .navigationView()
            .view(MatchDetailView.self, 0)
            .zStack()
        try zstack.callOnAppear()

        XCTAssertEqual(zstack.findAll(TeamHeaderView.self).count, 0)
        XCTAssertEqual(zstack.findAll(PlayerRow.self).count, 0)
        XCTAssertEqual(zstack.findAll(ViewType.ProgressView.self).count, 1)
    }
}
