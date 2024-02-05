//
//  ConversionInterface.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol ConversionInterface: ExchangeRateData, FilterHistoryInterface {
    func convertCurrency(from: String, to: String, amount: String) -> Double
}

extension ConversionInterface {
    func convertCurrency(from: String, to: String, amount: String) -> Double {
        guard let amountInDouble = Double(amount), amountInDouble > 0 else {
            return 0
        }
        let baseAmount = convertToBase(from: from, amount: amountInDouble)
        let convertedAmount = convertActualCurrency(to: to, baseAmount: baseAmount)
        return convertedAmount
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
