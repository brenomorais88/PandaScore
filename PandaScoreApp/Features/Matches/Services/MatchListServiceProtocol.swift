//
//  MatchListServiceProtocol.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Combine

protocol MatchServiceProtocol {
    func fetchUpcomingMatches(page: Int) -> AnyPublisher<[Match], Error>
}
