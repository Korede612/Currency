//
//  ChartViewModel.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

class ChartViewModel: ObservableObject, FilterHistoryInterface {
    @Published var data: [ConversionHistory] = []
    
    init() {
        self.data = getCurrentHistoryData()
    }
}
