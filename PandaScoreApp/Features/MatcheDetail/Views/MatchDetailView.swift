//
//  MatchDetailView.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import SwiftUI

struct MatchDetailView: View {
    @StateObject private var viewModel: MatchDetailViewModel

    init(viewModel: MatchDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingFullScreenIndicator

            } else {
                ScrollView {
                    VStack(spacing: 24) {
                        TeamHeaderView(
                            viewData: self.viewModel.viewData
                        )

                        VStack(spacing: 24) {
                            let team1Players = self.viewModel.t1players ?? []
                            let team2Players = self.viewModel.t2players ?? []
                            let maxCount = max(team1Players.count, team2Players.count)

                            ForEach(0..<maxCount, id: \.self) { idx in
                                PlayerRow(
                                    left: idx < team1Players.count ? team1Players[idx] : nil,
                                    right: idx < team2Players.count ? team2Players[idx] : nil
                                )
                            }
                        }
                    }
                    .padding(.top)
                }
                .background(AppColors.background.ignoresSafeArea())

            }
        }
        .navigationTitle(viewModel.viewData.viewTitle)        
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            viewModel.loadDetail()
        }
        .background(AppColors.background.ignoresSafeArea())
    }


    private var loadingFullScreenIndicator: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(2)
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.white)
        }
    }
}
