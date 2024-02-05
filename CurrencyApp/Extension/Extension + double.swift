//
//  Extension + double.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

extension Double {
    func convertToTime() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}
