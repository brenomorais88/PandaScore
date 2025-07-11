//
//  Match+extension.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

@testable import PandaScoreApp
import Foundation

extension Match {
    static func mock(id: Int = 1) -> Match {
        Match(
            id: id,
            oponentes: [
                Opponent(opponent: Team(name: "Team A", imageUrl: ""))
            ],
            league: League(name: "Mock League", imageUrl: ""),
            serie: Serie(fullName: "Serie A"),
            status: "not_started",
            beginAt: Date()
        )
    }
}
