//
//  CurrencyViewModel.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import RxSwift
import RxCocoa

class CurrencyViewModel {
    
    private let networkManager = NetworkManager.shared
    let disposableBag = DisposeBag()
    let errorMessage: BehaviorRelay = BehaviorRelay(value: "")
    var converList: [String: Double] = [:]
    
    var currencies: BehaviorRelay<[CurrencyItemInterface]> = BehaviorRelay(value: [])
    
    var convertedAmount: BehaviorRelay<String> = BehaviorRelay(value: "")
    var swappedCurrencyValue: BehaviorRelay<(String, String)> = BehaviorRelay(value: ("", ""))
    var swappedAmountValue: BehaviorRelay<(String, String)> = BehaviorRelay(value: ("", ""))
    
    init() {
        currencies.accept(optionList)
    }
    
    func convert(from: String, to: String, amount: String) {
        let newConvertedAmount = convertCurrency(from: from,
                                            to: to,
                                            amount: amount)
        let convertedData = String(format: "%.2f", newConvertedAmount).formattedCurrency
        convertedAmount.accept(convertedData)
        persistConversion(from: from,
                          to: to,
                          amountInDouble: Double(amount) ?? 0,
                          convertedAmount: newConvertedAmount)
    }
    
    func swapCurrency(from: String, to: String) {
        if (from == "From" || to == "To") {
            return
        }
        swappedCurrencyValue.accept((to, from))
    }
    
    func swapAmount(fromAmount: String, toAmount: String) {
        swappedAmountValue.accept((toAmount, fromAmount))
    }
    
    func configureURL() -> URL? {
        guard let apiUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)") else {
            return nil
        }
        return apiUrl
    }
    
    func fetchData() {
        let canNetwork = checkCanMakeNetworkCallTime()
        if canNetwork {
            guard let url = configureURL() else {
                return
            }
            networkManager.fetchNetworkData(apiUrl: url, type: CurrenciesInfo.self)
                .subscribe(
                    onNext: { [weak self] result in
                        guard let self else { return }
                        
                        switch result {
                        case .success(let data):
                            if data.success {
                                let time = data.timestamp.convertToTime()
                                preserveToUserdefault(time,
                                                      account: "networkCall")
                                preserveToUserdefault(data.rates,
                                                      account: "exchangeRate")
                                converList = data.rates
                            }
                            
                        case .failure(let error):
                            errorMessage.accept(error.localizedDescription)
                        }
                    },
                    onError: { [weak self] error in
                        self?.errorMessage.accept(error.localizedDescription)
                    }
                )
                .disposed(by: disposableBag)
        } else {
            guard let retreivedData = retrieveData(for: "exchangeRate", type: [String: Double].self) else {
                return
            }
            converList = retreivedData
        }
        
    }
}

extension CurrencyViewModel: FixerKey { }
extension CurrencyViewModel: NetworkTimeInterval { }
extension CurrencyViewModel: OptionItemInterface { }
extension CurrencyViewModel: ConversionInterface { }
extension CurrencyViewModel: PersistConversion { }
