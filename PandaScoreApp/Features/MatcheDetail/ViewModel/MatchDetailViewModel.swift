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

        let id1 = viewData.team1?.id ?? 0
        let id2 = viewData.team2?.id ?? 0

        Publishers.Zip(
            service.fetchPlayers(teamId: id1),
            service.fetchPlayers(teamId: id2)
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            self?.isLoading = false
            if case let .failure(err) = completion {
                self?.error = err
            }
        } receiveValue: { [weak self] players1, players2 in
            self?.t1players = players1
            self?.t2players = players2
        }
        .store(in: &cancellables)
    }
}
