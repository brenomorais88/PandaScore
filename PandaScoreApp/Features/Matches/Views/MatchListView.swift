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
            .onAppear {
                viewModel.fetchMatches()
            }
        }
    }

    private var matchList: some View {
        List {
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
        .listStyle(.plain)
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
