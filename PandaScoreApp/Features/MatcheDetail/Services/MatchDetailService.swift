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
    private let baseURL = APIConfig.baseURL
    private let apiKey = APIConfig.apiKey

    // MARK: - Init

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = MatchDetailService.defaultDecoder
    ) {
        self.session = session
        self.decoder = decoder
    }

    public func fetchMatchDetail(id: Int) -> AnyPublisher<MatchDetail, Error> {
        guard let url = buildURL(forId: id) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        print(url)

        let request = URLRequest(url: url)

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MatchDetail.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Helpers
    
    private func buildURL(forId id: Int) -> URL? {
        var components = URLComponents(string: "\(baseURL)/\(id)")
        components?.queryItems = [ .init(name: "token", value: apiKey) ]
        return components?.url
    }

    // MARK: - Static Defaults

    private static var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
