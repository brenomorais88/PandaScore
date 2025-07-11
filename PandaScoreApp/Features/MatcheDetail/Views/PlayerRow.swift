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
        HStack(spacing: 16) {
            if let p = left {
                PlayerCell(player: p)
            } else {
                Spacer()
            }

            Spacer()

            if let p = right {
                PlayerCell(player: p)
            } else {
                Spacer()
            }
        }
        .padding(12)
        .background(Color("RowBackground"))
        .clipShape(
            RoundedCorner(radius: 10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
        )
    }
}

private struct PlayerCell: View {
    let player: MatchDetail.Player

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(player.nickname)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(player.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            AsyncImage(url: player.imageUrl) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.3))
                }
            }
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}
