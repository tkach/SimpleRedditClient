//
// Created by Alexander Tkachenko on 9/10/17.
//

import Foundation

final class DateFormatter {
    func formattedDate(date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        let now = Date()
        guard let timeString = formatter.string(from: date, to: now) else {
            return ""
        }
        let formatString = NSLocalizedString("%@ ago", comment: "")
        return String(format: formatString, timeString)
    }
}
