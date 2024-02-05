//
//  Extension + Date.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

extension Date {
    func addTime(by time: Double) -> Self {
        self.addingTimeInterval(time)
    }
    
    func isDateWithinLast3Days() -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()

        // Calculate the date 3 days ago from the current date
        if let threeDaysAgo = calendar.date(byAdding: .day, value: -3, to: currentDate) {
            // Compare the given date with the date 3 days ago
            return self >= threeDaysAgo && self <= currentDate
        }

        // Return false if there is an issue with date calculation
        return false
    }
}
