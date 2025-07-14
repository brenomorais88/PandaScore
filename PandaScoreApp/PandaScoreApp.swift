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
        let rawBackImage = UIImage(named: "back_btn")
        let backImage = rawBackImage?.withRenderingMode(.alwaysTemplate)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.background
        appearance.shadowColor = .clear
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        let backButtonItem = appearance.backButtonAppearance
        backButtonItem.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
        backButtonItem.highlighted.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]

        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.compactScrollEdgeAppearance = appearance
        navBar.tintColor = .white
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MatchListView(viewModel: matchListViewModel)
            }
        }
    }
}
