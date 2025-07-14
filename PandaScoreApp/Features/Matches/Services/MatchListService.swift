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
    private let baseMatchesURL = APIConfig.baseURL + "csgo/matches"
    private let apiKey = APIConfig.apiKey
    private let itemsPerPage = 20
    private let hoursAhead = 72

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
            .tryMap { result -> Data in
                if let httpResponse = result.response as? HTTPURLResponse,
                   !(200...299).contains(httpResponse.statusCode) {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: [Match].self, decoder: decoder)
            .map { matches in
                let running = matches.filter { $0.status == "running" }
                let others = matches
                    .filter { $0.status != "running" }
                    .sorted { lhs, rhs in
                        switch (lhs.beginAt, rhs.beginAt) {
                        case let (l?, r?):      return l < r
                        case (nil, _?):         return false
                        case (_?, nil):         return true
                        default:                return false
                        }
                    }
                return running + others
            }
            .handleEvents(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let decodingError = error as? DecodingError {
                        debugPrint(decodingError)
                    }
                case .finished:
                    print("[MatchService] Partidas carregadas com sucesso.")
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }


    // MARK: - Private Helpers

    private func buildURL(forPage page: Int) -> URL? {
        guard let startDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date()),
              let futureDate = Calendar.current.date(byAdding: .hour, value: hoursAhead, to: Date()) else {
            return nil
        }

        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current

        let fromString = formatter.string(from: startDate)
        let toString = formatter.string(from: futureDate)

        var components = URLComponents(string: baseMatchesURL)
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

