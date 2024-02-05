//
//  NetworkTimeInterval.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation

protocol NetworkTimeInterval: DataStorable {
    func checkCanMakeNetworkCallTime() -> Bool
}

extension NetworkTimeInterval {
    
    func checkCanMakeNetworkCallTime() -> Bool {
        let time = fetchNextNetworkCalledTime()
        return canMakeNetworkCall(time: time)
    }
    
    func fetchNextNetworkCalledTime() -> Date? {
        let networkCallTime = retrieveData(for: "networkCall", type: Date.self)
        return networkCallTime?.addTime(by: 3600)
    }
    
    func canMakeNetworkCall(time: Date?) -> Bool {
        
        guard let nextNetworkCallTime = time else {
            return true
        }
        if nextNetworkCallTime > Date.now {
            return false
        }
        return true
    }
}
