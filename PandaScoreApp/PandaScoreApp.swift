//
//  PandaScoreAppApp.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import SwiftUI

@main
struct PandaScoreApp: App {

    private let matchService: MatchServiceProtocol = MatchService()
    private var matchListViewModel: MatchListViewModel {
        MatchListViewModel(service: matchService)
    }

    var body: some Scene {
        WindowGroup {
            MatchListView(viewModel: matchListViewModel)
        }
    }
}
