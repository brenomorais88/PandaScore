//
//  PlaceholderPlayerView.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 14/07/25.
//

import SwiftUI

struct PlaceholderPlayerView: View {
    var body: some View {
        Image("placeholder-player")
            .resizable()
            .scaledToFill()
            .frame(width: 52, height: 52)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
