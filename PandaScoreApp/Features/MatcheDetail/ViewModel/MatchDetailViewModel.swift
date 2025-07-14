//
//  MatchDetailViewModel.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine
import Foundation

public final class MatchDetailViewModel: ObservableObject {
    @Published public private(set) var isLoading = false
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
        loadTeam1Players()
        loadTeam2Players()
    }

    private func loadTeam1Players() {
        let teamId = self.viewData.team1?.id ?? 0

        service.fetchPlayers(teamId: teamId)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] players in
                self?.t1players = players
            }
            .store(in: &cancellables)
    }

    private func loadTeam2Players() {
        let teamId = self.viewData.team2?.id ?? 0

        service.fetchPlayers(teamId: teamId)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] players in
                self?.t2players = players
            }
            .store(in: &cancellables)
    }
}
