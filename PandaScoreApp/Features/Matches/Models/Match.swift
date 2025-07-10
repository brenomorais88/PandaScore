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

        enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
        }
    }

    struct League: Decodable {
        let name: String
        let imageUrl: String?
    }

    struct Serie: Decodable {
        let fullName: String?

        enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
        }
    }

    var team1: Team? { opponents.first?.opponent }
    var team2: Team? { opponents.dropFirst().first?.opponent }

    enum CodingKeys: String, CodingKey {
        case id, opponents, league, serie, status
        case beginAt = "begin_at"
        case fullName = "full_name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.opponents = try container.decode([Opponent].self, forKey: .opponents)
        self.league = try container.decode(League.self, forKey: .league)
        self.serie = try container.decode(Serie.self, forKey: .serie)
        self.status = try container.decode(String.self, forKey: .status)

        if let dateString = try? container.decodeIfPresent(String.self, forKey: .beginAt) {
            self.beginAt = ISO8601DateFormatter().date(from: dateString)
        } else {
            self.beginAt = nil
        }
    }
    
    init(id: Int, oponentes: [Opponent], league: League, serie: Serie, status: String, beginAt: Date?) {
        self.id = id
        self.opponents = oponentes
        self.league = league
        self.serie = serie
        self.status = status
        self.beginAt = beginAt
    }
}

