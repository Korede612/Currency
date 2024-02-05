//
//  CurrencyViewModelTest.swift
//  CurrencyAppTests
//
//  Created by Oko-osi Korede on 05/02/2024.
//

@testable import CurrencyApp
import XCTest
import RxSwift
import RxCocoa

final class CurrencyViewModelTest: XCTestCase {

    func testSuccesfulUrl() {
        let vm = CurrencyViewModel()
        let url = vm.configureURL()
        let resultURl = URL(string: "http://data.fixer.io/api/latest?access_key=91be1bb7e8da27062001e413f9bebf58")
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url, resultURl)
    }
}
