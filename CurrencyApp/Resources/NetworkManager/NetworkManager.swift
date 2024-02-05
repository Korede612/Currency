//
//  NetworkManager.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import RxSwift
import RxCocoa
enum NetworkError: Error {
    case dataCorrupted
}
class NetworkManager {

    static let shared = NetworkManager()
    private let disposeBag = DisposeBag()
    
    func fetchNetworkData<T: Codable>(apiUrl: URL) -> Observable<Result<T, NetworkError>> {
        return URLSession.shared.rx.data(request: URLRequest(url: apiUrl))
            .map { data in
                // Parse the data, assuming it's in JSON format
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    return .success(decodedData)
                } catch {
                    print("Error parsing JSON: \(error)")
                    return .failure(.dataCorrupted)
                }
            }
            .observe(on: MainScheduler.instance) // Ensure UI-related work is done on the main thread
    }
}
