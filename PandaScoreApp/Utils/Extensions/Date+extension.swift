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

    func formattedDateLabel() -> String {
        let calendar = Calendar.current
        let locale = Locale(identifier: "pt_BR")

        let hourFormatter = DateFormatter()
        hourFormatter.locale = locale
        hourFormatter.dateFormat = "HH:mm"

        if calendar.isDateInToday(self) {
            return "\(LocalizedStrings.DateLabel.today), \(hourFormatter.string(from: self))"

        } else if calendar.isDateInTomorrow(self) {
            return "\(LocalizedStrings.DateLabel.tomorrow), \(hourFormatter.string(from: self))"

        } else {
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.locale = locale
            weekdayFormatter.dateFormat = "E"

            let weekday = weekdayFormatter.string(from: self).capitalized
            let time = hourFormatter.string(from: self)
            return "\(weekday), \(time)"
        }
    }
}
