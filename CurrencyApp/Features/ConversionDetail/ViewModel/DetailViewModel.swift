//
//  DetailViewModel.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    
    let suggestedCurrency = ["CAD", "EUR", "NGN", "USD", "EGP", "GBP", "GHS", "JPY", "DKK", "BTC"]
    var data = BehaviorRelay<[ConversionHistory]>(value: [])
    var suggestedData = BehaviorRelay<[ConversionHistory]>(value: [])
    
    
    init() {
        let filteredData = getCurrentHistoryData()
        data.accept(filteredData)
    }
    
    func deleteItem(at indexPath: Int) {
        var dataToDeleteFrom = data.value
        dataToDeleteFrom.remove(at: indexPath)
        data.accept(dataToDeleteFrom)
        preserveToUserdefault(dataToDeleteFrom, account: "historyData")
    }
    
    func convertBaseCurrent(base: String, amount: String) {
        let amountInDouble = Double(amount) ?? 0
        var convertedData: [ConversionHistory] = []
        suggestedCurrency.forEach { currency in
            let convertedAmount = convertCurrency(from: base, to: currency, amount: amount)
            let doubleAmount = Double(convertedAmount) ?? 0
            let conversionHistory = ConversionHistory(currency: [base, currency], valueCount: [amountInDouble, doubleAmount], currencyFlag: [base, currency], date: .now)
            convertedData.append(conversionHistory)
        }
        suggestedData.accept(convertedData)
    }
}

extension DetailViewModel: FilterHistoryInterface { }
extension DetailViewModel: ConversionInterface { }
