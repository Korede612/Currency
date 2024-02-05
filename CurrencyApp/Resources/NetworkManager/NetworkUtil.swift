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
        Bundle.main.object(forInfoDictionaryKey: "MyFixerAPIKey") as! String
    }
}

protocol GetFlagInterface {
    func getFlag(for currency: String) -> String
}

extension GetFlagInterface {
    func getFlag(for currency: String) -> String {
        let base: UInt32 = 127397
        var code = currency.prefix(2).uppercased()
        print("Here is the country code: \(code)")

        var flag = ""
        for i in code.unicodeScalars {
            if let scalarValue = UnicodeScalar(base + i.value) {
                flag.append(String(scalarValue))
            }
        }
        print("Here is the country flag: \(flag)")
        return flag
    }
}


struct Currency: Identifiable {
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}
