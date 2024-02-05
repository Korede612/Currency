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

    var viewModel: CurrencyViewModel!
    var disposeBag: DisposeBag!

        override func setUp() {
            super.setUp()

           viewModel = CurrencyViewModel()
            disposeBag = DisposeBag()
        }

        override func tearDown() {
            // Clean up after each test
            viewModel = nil
            disposeBag = nil
            super.tearDown()
        }

    
    func testSuccesfulUrl() {
        let url = viewModel.configureURL()
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "FixerAPIKey") as! String
        let resultURl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)")
        
        XCTAssertNotNil(url)
        XCTAssertEqual(url, resultURl)
    }
    
    func testCanMakeFirstNetworkCall() {
        let time: Double = 1706968683
        let camMakenetworkCall = viewModel.canMakeNetworkCall(time: nil)
        
        XCTAssertTrue(camMakenetworkCall)
    }
    
    func testCanMakeNetworkCall() {
        let time: Double = 1706968683
        let date = time.convertToTime()
        
        let camMakenetworkCall = viewModel.canMakeNetworkCall(time: date)
        
        XCTAssertTrue(camMakenetworkCall)
    }
    
    func testCanNotMakeNetworkCall() {
        let date = Date.now.addTime(by: 3600)
        
        let camMakenetworkCall = viewModel.canMakeNetworkCall(time: date)
        
        XCTAssertFalse(camMakenetworkCall)
    }
    
    func testFetchNextNetworkCalledTime() {
        let time: Double = 1706968681
        let randomNetworkTime = time.convertToTime()
        let networkTime = viewModel.fetchNextNetworkCalledTime()
        
        XCTAssertNotEqual(randomNetworkTime, networkTime)
    }
}
