//
//  MatchDetail+extension.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

@testable import PandaScoreApp
import Foundation

extension MatchDetail {
    static func mock(id: Int = 1) -> MatchDetail.Player {
        MatchDetail.Player(id: id,
                           name: "player_nick_\(id)",
                           firstName: "Player\(id)",
                           lastName: "lastName",
                           imageUrl: nil)
    }
}
