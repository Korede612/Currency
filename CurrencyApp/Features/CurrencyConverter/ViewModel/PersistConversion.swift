//
//  PersistConversion.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol PersistConversion: FilterHistoryInterface {
    func persistConversion(from: String, to: String, amountInDouble: Double, convertedAmount: Double)
}

extension PersistConversion {
    func persistConversion(from: String, to: String, amountInDouble: Double, convertedAmount: Double) {
        // Persisting the conversion data here
        let date = Date.now
        let currency = ["\(from)-\(date)", "\(to)-\(date)"]
        let values = [amountInDouble, convertedAmount]
        let currencyFlag = [from, to]
        let convertHistory = ConversionHistory(currency: currency, valueCount: values, currencyFlag: currencyFlag, date: date)
        
        var currentHistoryData = getCurrentHistoryData()
        currentHistoryData.append(convertHistory)
        
        preserveToUserdefault(currentHistoryData, account: "historyData")
    }
}
