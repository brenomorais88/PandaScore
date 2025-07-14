//
//  TeamHeaderView.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import SwiftUI

struct TeamHeaderView: View {
    let viewData: MatchDetailViewData

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 48) {
                TeamLogoView(team: viewData.team1)
                Text(LocalizedStrings.TeamHeaderView.versus)
                    .font(.headline)
                    .foregroundColor(.white)
                TeamLogoView(team: viewData.team2)
            }

            Text(viewData.beginAt.formattedDateLabel())
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(8)
        }
    }
}

struct TeamLogoView: View {
    let team: Match.Team?

    var body: some View {
        VStack(spacing: 6) {

            if let imageUrl: URL = URL(string: team?.imageUrl ?? "") {
                AsyncImage(url: imageUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        PlaceholderTeamView()
                    }
                }
                .frame(width: 64, height: 64)
                .clipShape(Circle())
            } else {
                PlaceholderTeamView()
            }

            Text(team?.name ?? "-")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}
