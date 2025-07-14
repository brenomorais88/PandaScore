//
//  PlayerRow.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 11/07/25.
//

import SwiftUI

struct PlayerRow: View {
    let left: MatchDetail.Player?
    let right: MatchDetail.Player?

    var body: some View {
        HStack() {
            PlayerCellLeft(player: left)

            Spacer()
                .frame(width: 24)

            PlayerCellRight(player: right)
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 60)
    }
}

private struct PlayerCellLeft: View {
    let player: MatchDetail.Player?

    var body: some View {
        HStack {
            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(player?.name ?? "-")
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(player?.firstName ?? "-")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            AsyncImage(url: player?.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                }
            }
            .frame(width: 52, height: 52)
            .padding(8)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .background(AppColors.card)
        .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomRight]))
    }
}

private struct PlayerCellRight: View {
    let player: MatchDetail.Player?

    var body: some View {
        HStack {
            AsyncImage(url: player?.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                }
            }
            .frame(width: 52, height: 52)
            .padding(8)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 4) {
                Text(player?.name ?? "-")
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(player?.firstName ?? "-")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            Spacer()
        }
        .background(AppColors.card)
        .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]))
    }
}
