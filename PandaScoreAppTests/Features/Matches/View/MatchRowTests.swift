//
//  MatchRowTests.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import PandaScoreApp

final class MatchRowTests: XCTestCase {

    func test_displaysTeamNamesAndVersus() throws {
        let match = makeMatch(
            team1Name: "Alpha",
            team2Name: "Bravo",
            leagueName: "Ligue",
            serieName: "SerieX",
            status: "",
            beginAt: nil
        )

        let view = MatchRow(match: match)
        let texts = try view
            .inspect()
            .findAll(ViewType.Text.self)
            .map { try $0.string() }

        XCTAssertTrue(texts.contains("Alpha"))
        XCTAssertTrue(texts.contains(LocalizedStrings.MatchRow.versus))
        XCTAssertTrue(texts.contains("Bravo"))
    }

    func test_showsLeagueAndSerieText() throws {
        let leagueName = "Champions"
        let serieName = "Final"
        let match = makeMatch(
            team1Name: "A", team2Name: "B",
            leagueName: leagueName,
            serieName: serieName,
            status: "",
            beginAt: nil
        )

        let view = MatchRow(match: match)
        let expected = "\(leagueName) • \(serieName)"
        let texts = try view
            .inspect()
            .findAll(ViewType.Text.self)
            .map { try $0.string() }

        XCTAssertTrue(texts.contains(expected))
    }

    func test_whenStatusRunning_showsNowBadge() throws {
        let match = makeMatch(
            team1Name: "A", team2Name: "B",
            leagueName: "L", serieName: "S",
            status: LocalizedStrings.MatchRow.running,
            beginAt: nil
        )

        let view = MatchRow(match: match)
        let zstack = try view.inspect().zStack()
        let badgeText = try zstack.group(1).text(0)
        XCTAssertEqual(try badgeText.string(), LocalizedStrings.MatchRow.now)
    }

    func test_whenBeginAtProvided_showsDateBadge() throws {
        let date = Date(timeIntervalSince1970: 1_632_000_000)
        let formatted = date.formattedDateLabel()

        let match = makeMatch(
            team1Name: "A", team2Name: "B",
            leagueName: "L", serieName: "S",
            status: "scheduled",
            beginAt: date
        )

        let view = MatchRow(match: match)
        let zstack = try view.inspect().zStack()
        let badgeText = try zstack.group(1).text(0)
        XCTAssertEqual(try badgeText.string(), formatted)
    }

    func test_whenNoBadgeConditions_doesNotShowBadge() throws {
        let match = makeMatch(
            team1Name: "A", team2Name: "B",
            leagueName: "L", serieName: "S",
            status: "scheduled",
            beginAt: nil
        )

        let view = MatchRow(match: match)
        XCTAssertThrowsError(try view.inspect().zStack().group(1).text(0))
    }

    //MARK: Helper to build a Match with two teams

    private func makeMatch(
        team1Name: String,
        team2Name: String,
        leagueName: String,
        serieName: String,
        status: String,
        beginAt: Date? = nil
    ) -> Match {

        let team1 = Match.Team(name: team1Name, imageUrl: "")
        let team2 = Match.Team(name: team2Name, imageUrl: "")
        let opponents = [
            Match.Opponent(opponent: team1),
            Match.Opponent(opponent: team2)
        ]
        let league = Match.League(name: leagueName, imageUrl: "")
        let serie = Match.Serie(fullName: serieName)
        return Match(
            id: 123,
            oponentes: opponents,
            league: league,
            serie: serie,
            status: status,
            beginAt: beginAt
        )
    }
}
