//
//  LocalizedStrings.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 09/07/25.
//

import Foundation

enum LocalizedStrings {
    enum MatchRow {
        static let team1Placeholder = "Time 1"
        static let team2Placeholder = "Time 2"
        static let versus = "vs"
        static let now = "AGORA"
        static let running = "running"
    }

    enum MatchList {
        static let title = "Partidas"
        static let loading = "Carregando..."
        static let emptyData = "Nenhuma partida encontrada."
    }

    enum MatchDetail {
        static let tryAgain = "Tentar Novamente"
        static let errorMessage = "Ops, algo deu errado"
    }

    enum DateLabel {
        static let today = "Hoje"
        static let tomorrow = "Amanhã"
    }

    enum TeamHeaderView {
        static let versus = "vs"
    }
}
