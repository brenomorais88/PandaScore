//
//  MatchDetail.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Foundation

public struct MatchDetail {

    public struct Player: Identifiable, Decodable {
        public let id: Int
        public let name: String
        public let firstName: String?
        public let lastName: String?
        public let imageUrl: URL?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case firstName = "first_name"
            case lastName  = "last_name"
            case imageUrl  = "image_url"
        }

        public var nickname: String { name }
    }
}
