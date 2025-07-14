//
//  MatchDetailViewModel.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine
import Foundation

public final class MatchDetailViewModel: ObservableObject {
    @Published public private(set) var players: [MatchDetail.Player]?
    @Published public private(set) var isLoading = false
    @Published public private(set) var error: Error?
    let viewData: MatchDetailViewData

    private let service: MatchDetailServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: MatchDetailServiceProtocol, viewData: MatchDetailViewData) {
        self.service = service
        self.viewData = viewData
    }

    public func loadDetail() {
        isLoading = true
//        let teamId = self.match?.team1?.id ?? 0
//
//        service.fetchPlayers(teamId: teamId)
//            .sink { [weak self] completion in
//                self?.isLoading = false
//                if case let .failure(err) = completion {
//                    self?.error = err
//                }
//            } receiveValue: { [weak self] players in
//                self?.players = players
//                print(players)
//            }
//            .store(in: &cancellables)
    }
}
