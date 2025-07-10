//
//  Date+extension.swift
//  PandaScoreApp
//
//  Created by Breno Morais on 08/07/25.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    func formattedHourLabel() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "HH:mm"

        if Calendar.current.isDateInToday(self) {
            return "\(LocalizedStrings.DateLabel.today), \(formatter.string(from: self))"
        } else if Calendar.current.isDateInTomorrow(self) {
            return "\(LocalizedStrings.DateLabel.tomorrow), \(formatter.string(from: self))"
        } else {
            formatter.dateFormat = "dd.MM HH:mm"
            return formatter.string(from: self)
        }
    }

    func formattedScheduleLabel() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "dd.MM HH:mm"
        return formatter.string(from: self)
    }
}
