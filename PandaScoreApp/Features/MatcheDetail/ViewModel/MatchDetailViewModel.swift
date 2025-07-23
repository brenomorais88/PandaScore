//
//  MatchDetailViewModel.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine
import Foundation

public class MatchDetailViewModel: ObservableObject {
    @Published public var isLoading = false
    @Published public private(set) var error: Error?

    var t1players: [MatchDetail.Player]?
    var t2players: [MatchDetail.Player]?
    let viewData: MatchDetailViewData

    private let service: MatchDetailServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: MatchDetailServiceProtocol, viewData: MatchDetailViewData) {
        self.service = service
        self.viewData = viewData
    }

    public func loadDetail() {
        isLoading = true

        let player1ID = self.viewData.team1?.id ?? 0
        loadPlayer(teamId: player1ID)

        let player2ID = self.viewData.team2?.id ?? 0
        loadPlayer(teamId: player2ID)
    }

    private func loadPlayer(teamId: Int) {
        service.fetchPlayers(teamId: teamId)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] players in
                if teamId == self?.viewData.team1?.id {
                    self?.t1players = players
                } else {
                    self?.t2players = players
                }
            }
            .store(in: &cancellables)
    }
}
