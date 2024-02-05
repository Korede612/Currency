//
//  CurrencyItem.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import Foundation

protocol CurrencyItemInterface {
    var value: String? { get set }
    var icon: String? { get set }
}

struct CurrencyItem: CurrencyItemInterface {
    var value: String?
    var icon: String?
}


