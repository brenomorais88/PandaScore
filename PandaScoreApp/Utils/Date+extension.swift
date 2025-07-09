//
//  Date+extension.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Foundation

extension Date {
    func formattedHourLabel() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "HH:mm"

        if Calendar.current.isDateInToday(self) {
            return "Hoje, \(formatter.string(from: self))"
        } else if Calendar.current.isDateInTomorrow(self) {
            return "Amanhã, \(formatter.string(from: self))"
        } else {
            formatter.dateFormat = "dd.MM HH:mm"
            return formatter.string(from: self)
        }
    }
}
