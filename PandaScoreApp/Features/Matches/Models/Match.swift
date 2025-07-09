//
//  Match.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Foundation

struct Match: Decodable, Identifiable {
    let id: Int
    let opponents: [Opponent]
    let league: League
    let serie: Serie
    let status: String
    let beginAt: Date?

    struct Opponent: Decodable {
        let opponent: Team
    }

    struct Team: Decodable {
        let name: String
        let imageUrl: String?
    }

    struct League: Decodable {
        let name: String
        let imageUrl: String?
    }

    struct Serie: Decodable {
        let fullName: String
    }

    var team1: Team? { opponents.first?.opponent }
    var team2: Team? { opponents.dropFirst().first?.opponent }
}
