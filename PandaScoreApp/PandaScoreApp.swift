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

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(named: "BackgroundColor") ?? .black
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MatchListView(viewModel: matchListViewModel)
            }
        }
    }
}
