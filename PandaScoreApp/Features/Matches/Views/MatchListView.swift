//
//  MatchListView.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import SwiftUI

struct MatchListView: View {
    @StateObject private var viewModel: MatchListViewModel

    init(viewModel: MatchListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.matches.isEmpty && !viewModel.isLoading {
                    Text(LocalizedStrings.MatchList.emptyData)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    matchList
                }
            }
            .navigationTitle(LocalizedStrings.MatchList.title)
            .foregroundStyle(.white)
            .background(AppColors.background.ignoresSafeArea())
            .toolbarBackground(AppColors.background, for: .navigationBar)
            .onAppear {
                viewModel.fetchMatches()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var matchList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.matches) { match in
                    MatchRow(match: match)
                        .onAppear {
                            if match.id == viewModel.matches.last?.id {
                                viewModel.fetchMatches()
                            }
                        }
                }

                if viewModel.isLoading {
                    loadingIndicator
                }
            }
        }
        .refreshable {
            viewModel.refresh()
        }
    }

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView(LocalizedStrings.MatchList.loading)
                .padding()
            Spacer()
        }
    }
}
