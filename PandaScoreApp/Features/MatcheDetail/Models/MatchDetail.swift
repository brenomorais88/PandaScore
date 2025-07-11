//
//  MatchDetail.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Foundation

public struct MatchDetail: Decodable {
    public let id: Int
    public let beginAt: Date
    public let league: League
    public let serie: Serie
    public let opponents: [Opponent]
    public let rosters: [Roster]
    // …outros campos que precisar

    // sub-models inline ou em arquivos separados
    public struct League: Decodable {

    }

    public struct Serie: Decodable {

    }

    public struct Opponent: Decodable {
        public let opponent: Team
    }

    public struct Team: Decodable {
        public let id: Int
        public let name: String
        public let imageUrl: URL?
    }

    public struct Roster: Decodable {
        public let teamId: Int
        public let players: [Player]
    }

    public struct Player: Decodable {
        public let id: Int
        public let name: String
        public let nickname: String
        public let imageUrl: URL?
    }
}
