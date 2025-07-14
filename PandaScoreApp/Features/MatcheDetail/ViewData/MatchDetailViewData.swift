//
//  MatchDetailViewData.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import Foundation

class MatchDetailViewData {
    let team1: Match.Team?
    let team2: Match.Team?
    let beginAt: Date
    let viewTitle: String

    init(team1: Match.Team?, team2: Match.Team?, beginAt: Date, viewTitle: String) {
        self.team1 = team1
        self.team2 = team2
        self.beginAt = beginAt
        self.viewTitle = viewTitle
    }
}
