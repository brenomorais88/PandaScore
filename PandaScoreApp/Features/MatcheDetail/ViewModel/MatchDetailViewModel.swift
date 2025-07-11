//
//  MatchDetailViewModel.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import Combine
import Foundation

public final class MatchDetailViewModel: ObservableObject {
    @Published public private(set) var match: MatchDetail?
    @Published public private(set) var isLoading = false
    @Published public private(set) var error: Error?

    private let service: MatchDetailServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let detailId: Int

    public init(service: MatchDetailServiceProtocol, detailId: Int) {
        self.service = service
        self.detailId = detailId
    }

    public func loadDetail() {
        isLoading = true
        service.fetchMatchDetail(id: self.detailId)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] detail in
                self?.match = detail
            }
            .store(in: &cancellables)
    }
}
