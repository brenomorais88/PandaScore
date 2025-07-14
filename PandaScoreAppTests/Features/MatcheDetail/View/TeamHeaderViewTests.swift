//
//  TeamHeaderViewTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import PandaScoreApp

final class TeamHeaderViewTests: XCTestCase {

    func test_teamHeader_show_teams_and_name() throws {
        let team1 = Match.Team(id: 1, name: "Team Alpha", imageUrl: "...")
        let team2 = Match.Team(id: 2, name: "Team Beta",  imageUrl: "...")
        let date  = Date(timeIntervalSince1970: 1_700_000_000)

        let viewData = MatchDetailViewData(
            team1: team1,
            team2: team2,
            beginAt: date,
            viewTitle: "Custom title"
        )

        let sut = NavigationView {
            TeamHeaderView(viewData: viewData)
        }

        let vstack = try sut.inspect()
            .navigationView()
            .view(TeamHeaderView.self, 0)
            .vStack()

        let hstack = try vstack.hStack(0)
        let teamLogoViews = hstack.findAll(TeamLogoView.self)
        XCTAssertEqual(teamLogoViews.count, 2)
    }
}

