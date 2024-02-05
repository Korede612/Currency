//
//  NetworkManager.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import RxSwift
import RxCocoa

enum NetworkError: String, Error {
    case dataCorrupted = "Unable to convert data"
    case networkError = "Check your network connnection"
}
class NetworkManager {

    static let shared = NetworkManager()
    private let disposeBag = DisposeBag()
    
    func fetchNetworkData<T: Codable>(apiUrl: URL, type: T.Type) -> Observable<Result<T, NetworkError>> {
        return URLSession.shared.rx.data(request: URLRequest(url: apiUrl))
            .map { data in
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    return .failure(.dataCorrupted)
                }
            }
            .observe(on: MainScheduler.instance)
    }
}
