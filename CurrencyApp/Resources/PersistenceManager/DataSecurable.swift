//
//  DataSecurable.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import Foundation
protocol DataSecurable {
    static func set(value: Data, account: String) throws
    static func get(account: String) throws -> Data?
    static func delete(account: String) throws
    static func deleteAll() throws
}
