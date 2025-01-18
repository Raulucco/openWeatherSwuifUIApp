//
//  Week.swift
//  swiftui-weather-app
//
//  Created by Raul CM on 19.12.2024.
//

import Foundation

struct Day: Hashable {
    var date: Date

    var day: String {
        return date.formatted(Date.FormatStyle().day(.twoDigits))
    }

    var weekDay: String {
        return date.formatted(Date.FormatStyle().weekday(.abbreviated))
    }
}

func getToday() -> Day {
    return Day(date: Date())
}

func getNextDays(totalDays: Int) -> [Day] {
    var days: [Day] = []
    let anchor = Date()
    let calendar = Calendar.current

    for dayOffset in 0..<totalDays {
        if let date = calendar.date(
            byAdding: .day, value: dayOffset + 1, to: anchor)
        {
            days.append(Day(date: date))
        }
    }

    return days
}
