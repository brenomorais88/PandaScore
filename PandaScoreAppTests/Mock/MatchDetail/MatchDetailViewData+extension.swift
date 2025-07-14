//
//  MatchDetailViewData+extension.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

@testable import PandaScoreApp
import Foundation

extension MatchDetailViewData {
    static func mock(title: String = "Title") -> MatchDetailViewData {

        MatchDetailViewData(team1: Match.Team(id: 1, name: "Team A", imageUrl: ""),
                            team2: Match.Team(id: 2, name: "Team B", imageUrl: ""),
                            beginAt: Date(),
                            viewTitle: title)
    }
}
