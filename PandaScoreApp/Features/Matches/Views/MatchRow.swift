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
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.card)
                .frame(height: 176)
                .overlay(
                    VStack(spacing: 0) {
                        Spacer()

                        HStack {
                            teamView(team: match.team1)

                            Text(LocalizedStrings.MatchRow.versus)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)

                            teamView(team: match.team2)
                        }
                        .padding(.horizontal, 24)

                        Spacer()

                        Divider()
                            .background(Color.white)

                        HStack(spacing: 8) {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 16, height: 16)

                            Text("\(match.league.name) • \(match.serie.fullName ?? "")")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .lineLimit(1)

                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(AppColors.card)
                        .cornerRadius(12)
                    }
                )

            badgeText
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 6)
    }

    private var badgeText: some View {
        let text: String?
        let background: Color

        if match.status == LocalizedStrings.MatchRow.running {
            text = LocalizedStrings.MatchRow.now
            background = AppColors.liveRed

        } else if let beginAt = match.beginAt {
            text = beginAt.formattedDateLabel()
            background = AppColors.todayGray.opacity(0.2)

        } else {
            text = nil
            background = .clear
        }

        return Group {
            if let text {
                Text(text)
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(background)
                    .clipShape(RoundedCorner(radius: 8, corners: [.topRight, .bottomLeft]))
            }
        }
    }

    private func teamView(team: Match.Team?) -> some View {
        VStack(spacing: 4) {
            AsyncImage(url: URL(string: team?.imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                PlaceholderTeamView()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())

            Text(team?.name ?? "-")
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(1)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    let oponentes: [Match.Opponent] = [
        Match.Opponent(opponent: Match.Team(id: 1, name: "Teste nome 1", imageUrl: "")),
        Match.Opponent(opponent: Match.Team(id: 2, name: "Teste nome 2", imageUrl: ""))
    ]

    let match = Match(id: 1,
                      oponentes: oponentes,
                      league: Match.League(name: "teste", imageUrl: "link_foto"),
                      serie: Match.Serie(fullName: "teste Serie n"),
                      status: "runn",
                      beginAt: Date().advanced(by: 993600)
    )

    MatchRow(match: match)
}
