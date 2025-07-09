//
//  MatchListService.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Foundation
import Combine

class MatchService: MatchServiceProtocol {

    // MARK: - Constants
    private let session: URLSession
    private let decoder: JSONDecoder
    private let baseURL = APIConfig.baseURL
    private let apiKey = APIConfig.apiKey
    private let itemsPerPage = 20
    private let hoursAhead = 24

    // MARK: - Init

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = MatchService.defaultDecoder
    ) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Public Methods

    func fetchUpcomingMatches(page: Int) -> AnyPublisher<[Match], Error> {
        guard let url = buildURL(forPage: page) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = URLRequest(url: url)

        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Match].self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Private Helpers

    private func buildURL(forPage page: Int) -> URL? {
        let now = Date()
        guard let futureDate = Calendar.current.date(byAdding: .hour, value: hoursAhead, to: now) else {
            return nil
        }

        let formatter = ISO8601DateFormatter()
        let fromString = formatter.string(from: now)
        let toString = formatter.string(from: futureDate)

        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "range[begin_at]", value: "\(fromString),\(toString)"),
            URLQueryItem(name: "per_page", value: "\(itemsPerPage)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort", value: "begin_at"),
            URLQueryItem(name: "token", value: apiKey)
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

