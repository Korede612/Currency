//
//  FilterHistoryInterface.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

protocol FilterHistoryInterface: DataStorable {
    func getCurrentHistoryData() -> [ConversionHistory]
}

extension FilterHistoryInterface {
    func getCurrentHistoryData() -> [ConversionHistory] {
        let retrievedData = retrieveData(for: "historyData", type: [ConversionHistory].self) ?? []
        return retrievedData.filter({$0.lastThreeDays})
    }
}
