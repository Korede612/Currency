//
//  ConversionHistory.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

struct ConversionHistory: Identifiable, Codable, GetFlagInterface {
    var id = UUID()
    let currency: [String]
    let valueCount: [Double]
    var currencyFlag: [String] = []
    let date: Date
    
    var lastThreeDays: Bool {
        return date.isDateWithinLast3Days()
    }
    
    var fromFlag: String {
        if currency.count >= 1 {
            return getFlag(for: currencyFlag[0])
        } else {
            return ""
        }
    }
    
    var toFlag: String {
        if currency.count >= 2 {
            return getFlag(for: currencyFlag[1])
        } else {
            return ""
        }
    }
    
    var fromAmount: String {
        if valueCount.count >= 1 {
            return String(format: "%.2f", valueCount[0])
        } else {
            return "0"
        }
    }
    
    var toAmount: String {
        if valueCount.count >= 2 {
            return String(format: "%.2f", valueCount[1])
        } else {
            return "0"
        }
    }
}
