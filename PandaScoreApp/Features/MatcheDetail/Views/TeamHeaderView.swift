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
                Text("vs")
                    .font(.headline)
                    .foregroundColor(.white)
                TeamLogoView(team: viewData.team2)
            }

            Text(dateLabel)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }

    private var dateLabel: String {
        let df = DateFormatter()
        df.locale = .current
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: self.viewData.beginAt)
    }
}

private struct TeamLogoView: View {
    let team: Match.Team?

    var body: some View {
        VStack(spacing: 6) {
//            AsyncImage(url: team.imageUrl) { phase in
//                if let image = phase.image {
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } else {
//                    Circle()
//                        .fill(Color.gray.opacity(0.3))
//                }
//            }
//            .frame(width: 64, height: 64)
//            .clipShape(Circle())

            Text(team?.name ?? "-")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}
