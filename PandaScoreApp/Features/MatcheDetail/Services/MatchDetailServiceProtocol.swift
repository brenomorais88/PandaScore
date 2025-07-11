//
//  MatchDetailServiceProtocol.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine

public protocol MatchDetailServiceProtocol {
    func fetchMatchDetail(id: Int) -> AnyPublisher<MatchDetail, Error>
}
