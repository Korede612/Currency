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
}
