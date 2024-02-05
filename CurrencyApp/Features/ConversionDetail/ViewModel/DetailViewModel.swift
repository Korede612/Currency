//
//  DetailViewModel.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    var data = BehaviorRelay<[ConversionHistory]>(value: [])
    
    init() {
        let filteredData = getCurrentHistoryData()
        data.accept(filteredData)
    }
}

extension DetailViewModel: FilterHistoryInterface { }
