//
//  NetworkUtil.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol FixerKey {
    var apiKey: String { get }
}

extension FixerKey {
    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "FixerAPIKey") as! String
    }
}

protocol GetFlagInterface {
    func getFlag(for currency: String) -> String
}

extension GetFlagInterface {
    func getFlag(for currency: String) -> String {
        let base: UInt32 = 127397
        let code = currency.prefix(2).uppercased()

        var flag = ""
        for i in code.unicodeScalars {
            if let scalarValue = UnicodeScalar(base + i.value) {
                flag.append(String(scalarValue))
            }
        }
        return flag
    }
}
