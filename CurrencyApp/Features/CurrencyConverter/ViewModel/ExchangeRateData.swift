//
//  ExchangeRateData.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol ExchangeRateData: DataStorable {
    var exchangeRateData: [String: Double] { get }
}

extension ExchangeRateData {
    var exchangeRateData: [String: Double] {
        return retrieveData(for: "exchangeRate", type: [String: Double].self) ?? [:] // will be removing this later
    }
}
