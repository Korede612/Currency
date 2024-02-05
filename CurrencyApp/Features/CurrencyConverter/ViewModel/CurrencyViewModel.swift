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
                        // Notify the view that data is fetched
                        switch result {
                        case .success(let data):
                            print("data: ---\n\(data)")
                            let time = data.timestamp.convertToTime()
                            preserveToUserdefault(time,
                                                  account: "networkCall")
                            preserveToUserdefault(data.rates, 
                                                  account: "conversionList")
                            converList = data.rates
                        case .failure(let error):
                            errorMessage.accept(error.localizedDescription)
                        }
                    },
                    onError: { error in
                        // Handle the error if needed
                        print("Error fetching data: \(error)")
                    }
                )
                .disposed(by: disposableBag)
        } else {
            guard let retreivedData = retrieveData(for: "conversionList", type: [String: Double].self) else {
                return
            }
            converList = retreivedData
        }
        
    }
}

extension CurrencyViewModel: FixerKey { }
extension CurrencyViewModel: NetworkTimeInterval { }
