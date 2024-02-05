//
//  ConversionHistory.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

struct ConversionHistory: Identifiable, Codable {
    var id = UUID()
    let currency: [String]
    let valueCount: [Double]
    var currencyFlag: [String] = []
    let date: Date
    
    var lastThreeDays: Bool {
        return date.isDateWithinLast3Days()
    }
}
