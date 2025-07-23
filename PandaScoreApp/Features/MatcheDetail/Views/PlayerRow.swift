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
            PlayerCell(position: .left, player: left)

            Spacer()
                .frame(width: 24)

            PlayerCell(position: .right, player: right)
        }
        .background(Color.clear)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 60)
    }
}

enum PlayerCellPosition {
    case right
    case left
}

private struct PlayerCell: View {
    let position: PlayerCellPosition
    let player: MatchDetail.Player?

    var body: some View {
        if position == .left {
            playerLeftView
        } else {
            playerRightView
        }
    }

    private var playerLeftView: some View {
        HStack {
            Spacer()
            textView
            playerImage
        }
        .background(AppColors.card)
        .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomRight]))
    }

    private var playerRightView: some View {
        HStack {
            playerImage
            textView
            Spacer()
        }
        .background(AppColors.card)
        .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .bottomLeft]))
    }

    private var textView: some View {
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
    }

    private var playerImage: some View {
        AsyncImage(url: player?.imageUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                PlaceholderPlayerView()
            }
        }
        .frame(width: 52, height: 52)
        .padding(8)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
