//
//  MatchListViewModel.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Foundation
import Combine

protocol MatchListViewModelProtocol: ObservableObject {
    var matches: [Match] { get }
    var isLoading: Bool { get }
    var canLoadMore: Bool { get }

    func fetchMatches(reset: Bool)
    func refresh()
}

class MatchListViewModel: MatchListViewModelProtocol {
    // MARK: - Public properties
    @Published var matches: [Match] = []
    @Published var isLoading = false
    @Published var canLoadMore = true

    // MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private let service: MatchServiceProtocol

    // MARK: - Init
    init(service: MatchServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods
    func fetchMatches(reset: Bool = false) {
        guard !isLoading, canLoadMore else { return }

        if reset {
            currentPage = 1
            matches = []
            canLoadMore = true
        }

        isLoading = true

        service.fetchUpcomingMatches(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.canLoadMore = false
                }
            }, receiveValue: { [weak self] newMatches in
                guard let self = self else { return }
                if newMatches.count < 20 {
                    self.canLoadMore = false
                }
                self.matches.append(contentsOf: newMatches)
                self.currentPage += 1
            })
            .store(in: &cancellables)
    }

    func refresh() {
        fetchMatches(reset: true)
    }
}
