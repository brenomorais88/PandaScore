//
//  MockMatchService.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine
@testable import PandaScoreApp

final class MockMatchService: MatchServiceProtocol {
    private(set) var requestedPages = [Int]()
    var callCount: Int = 0
    var fetchResult: Result<[Match], Error> = .success([])

    func fetchUpcomingMatches(page: Int) -> AnyPublisher<[Match], Error> {
        let result = fetchResult.publisher.eraseToAnyPublisher()
        requestedPages.append(page)
        callCount += 1
        return result
    }
}
