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

//                        VStack(spacing: 12) {
//                            let team1Id = match.opponents[0].opponent.id
//                            let team2Id = match.opponents[1].opponent.id
//                            let team1Players = match.rosters.first { $0.teamId == team1Id }?.players ?? []
//                            let team2Players = match.rosters.first { $0.teamId == team2Id }?.players ?? []
//                            let maxCount = max(team1Players.count, team2Players.count)
//
//                            ForEach(0..<maxCount, id: \.self) { idx in
//                                PlayerRow(
//                                    left: idx < team1Players.count ? team1Players[idx] : nil,
//                                    right: idx < team2Players.count ? team2Players[idx] : nil
//                                )
//                            }
//                        }
//                        .padding(.horizontal)
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

    private func errorScreen(error: Error) -> some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 48))
                    .foregroundColor(.yellow)

                Text(LocalizedStrings.MatchDetail.errorMessage)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text(error.localizedDescription)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Button(action: {
                    viewModel.loadDetail()
                }) {
                    Text(LocalizedStrings.MatchDetail.tryAgain)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .foregroundColor(AppColors.background)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
            .background(Color.black.opacity(0.5))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5)
            .padding(32)
        }
    }

}
