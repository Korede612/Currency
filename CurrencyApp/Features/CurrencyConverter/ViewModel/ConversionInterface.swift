//
//  ConversionInterface.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol ConversionInterface: ExchangeRateData, FilterHistoryInterface {
    func convertCurrency(from: String, to: String, amount: String) -> String
}

extension ConversionInterface {
    func convertCurrency(from: String, to: String, amount: String) -> String {
        guard let amountInDouble = Double(amount), amountInDouble > 0 else {
            return ""
        }
        let baseAmount = convertToBase(from: from, amount: amountInDouble)
        let convertedAmount = convertActualCurrency(to: to, baseAmount: baseAmount)
        // Persisting the conversion data here
        let date = Date.now
        let currency = ["\(from)-\(date)", "\(to)-\(date)"]
        let values = [amountInDouble, convertedAmount]
        let currencyFlag = [from, to]
        let convertHistory = ConversionHistory(currency: currency, valueCount: values, currencyFlag: currencyFlag, date: date)
        
        var currentHistoryData = getCurrentHistoryData()
        currentHistoryData.append(convertHistory)
        
        preserveToUserdefault(currentHistoryData, account: "historyData")
        return String(format: "%.2f", convertedAmount)
    }
    
    func convertToBase(from: String, amount: Double) -> Double{
        let fromRate = exchangeRateData[from] ?? 0
        return (amount / fromRate)
    }
    
    func convertActualCurrency(to: String, baseAmount: Double) -> Double {
        let toRate = exchangeRateData[to] ?? 0
        return (baseAmount * toRate)
    }
}
