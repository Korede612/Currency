//
//  CurrenciesInfo.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
struct CurrenciesInfo: Codable {
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: [String: Double]
}
