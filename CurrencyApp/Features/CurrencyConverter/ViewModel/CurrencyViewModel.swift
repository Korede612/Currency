//
//  CurrencyViewModel.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import Foundation

class CurrencyViewModel {
    
    
    func configureURL() -> URL? {
        guard let apiUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)") else {
            return nil
        }
        print("Here is my API Key: \(apiKey)")
        return apiUrl
    }
}

extension CurrencyViewModel: FixerKey { }
