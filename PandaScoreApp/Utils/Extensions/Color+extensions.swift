//
//  Color+extensions.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 09/07/25.
//

import SwiftUICore

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xff) / 255
        let g = Double((rgb >> 8) & 0xff) / 255
        let b = Double(rgb & 0xff) / 255
        let a = hex.count > 7 ? Double((rgb >> 24) & 0xff) / 255 : 1

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
