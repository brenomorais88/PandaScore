//
//  MatchDetailService.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Foundation
import Combine

public final class MatchDetailService: MatchDetailServiceProtocol {

    // MARK: - Constants
    private let session: URLSession
    private let decoder: JSONDecoder
    private let basePlayersURL = APIConfig.baseURL + "csgo/players"
    private let apiKey = APIConfig.apiKey

    // MARK: - Init

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = MatchDetailService.defaultDecoder
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func fetchPlayers(teamId: Int) -> AnyPublisher<[MatchDetail.Player], Error> {

        guard let url = buildURL(id: teamId) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result in
                guard let http = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                guard (200...299).contains(http.statusCode) else {
                    throw URLError(.init(rawValue: http.statusCode))
                }
                return result.data
            }
            .decode(type: [MatchDetail.Player].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Helpers

    private func buildURL(id: Int) -> URL? {
        var components = URLComponents(string: basePlayersURL)
        components?.queryItems = [
            .init(name: "filter[team_id]", value: "\(id)"),
            .init(name: "token",           value: apiKey)
        ]
        return components?.url
    }

    // MARK: - Static Defaults

    private static var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
