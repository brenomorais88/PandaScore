//
//  MockMatchDetailService.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import Combine
@testable import PandaScoreApp

final class MockMatchDetailService: MatchDetailServiceProtocol {
    var fetchResult: [Result<[MatchDetail.Player], Error>] = []
    
    var callCount = 0

    func fetchPlayers(teamId: Int) -> AnyPublisher<[MatchDetail.Player], Error> {
        guard callCount < fetchResult.count else {
            return Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        let result = fetchResult[callCount]
        callCount += 1
        switch result {
        case .success(let players):
            return Just(players)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
