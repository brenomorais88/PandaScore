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
        NavigationStack{
            Group {
                if viewModel.matches.isEmpty {
                    if !viewModel.isLoading {
                        emptyData
                    } else {
                        loadingFullScreenIndicator
                    }
                } else {
                    matchList
                }
            }
        }
        .navigationDestination(for: Int.self) { matchId in
            detailView(for: matchId)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(LocalizedStrings.MatchList.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(AppColors.background.ignoresSafeArea())
        .onAppear {
            viewModel.fetchMatches()
        }


    }

    private var matchList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.matches) { match in
                    NavigationLink(value: match.id) {
                        MatchRow(match: match)
                    }
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
            .padding(.top)
        }
        .refreshable {
            viewModel.refresh()
        }
    }

    private var emptyData: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()
            Text(LocalizedStrings.MatchList.emptyData)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
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

    private var loadingIndicator: some View {
        HStack {
            Spacer()
            ProgressView(LocalizedStrings.MatchList.loading)
                .padding()
                .foregroundColor(.white)
                .tint(.white)
            Spacer()
        }
    }

    private var detailView: some View {
        HStack {
            Spacer()
            ProgressView(LocalizedStrings.MatchList.loading)
                .padding()
                .foregroundColor(.white)
                .tint(.white)
            Spacer()
        }
    }

    private func detailView(for matchId: Int) -> some View {
        let service = MatchDetailService()
        let vm = MatchDetailViewModel(service: service, detailId: matchId)
        return MatchDetailView(viewModel: vm)
    }
}
