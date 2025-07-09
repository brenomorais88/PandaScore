//
//  MatchRow.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import SwiftUI

struct MatchRow: View {
    let match: Match

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                AsyncImage(url: URL(string: match.team1?.imageUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                }
                .frame(width: 40, height: 40)

                Text(match.team1?.name ?? LocalizedStrings.MatchRow.team1Placeholder)

                Spacer()

                Text(LocalizedStrings.MatchRow.versus)

                Spacer()

                AsyncImage(url: URL(string: match.team2?.imageUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(Color.gray).frame(width: 40, height: 40)
                }
                .frame(width: 40, height: 40)

                Text(match.team2?.name ?? LocalizedStrings.MatchRow.team2Placeholder)
            }

            HStack {
                if let date = match.beginAt {
                    Text(date.formattedHourLabel())
                        .font(.caption)
                        .padding(4)
                        .background(Capsule().fill(Color.gray.opacity(0.2)))
                }

                Spacer()

                if match.status == "running" {
                    Text(LocalizedStrings.MatchRow.now)
                        .font(.caption).bold()
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Capsule().fill(Color.red))
                }
            }

            Text("\(match.league.name) • \(match.serie.fullName)")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}


