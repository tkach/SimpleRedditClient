//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class DateFormatter {
    private lazy var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        return formatter
    }()

    func formattedDate(date: Date) -> String {
        let now = Date()
        guard let timeString = formatter.string(from: date, to: now) else {
            return ""
        }
        let ago = "DateFormatter.Ago".localized()
        return timeString + " " + ago
    }
}
