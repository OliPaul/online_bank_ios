//
//  GetExchangeRate.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import Foundation

class GetExchangeRate: ObservableObject {
    
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(completion: @escaping (ExchangeRate) -> ()) {
        let userString: Data? = Keychain().get(key: "user")
        let user = try! JSONDecoder().decode(LoginResponse.self, from: userString!)
        guard let url = URL(string: "\(backUrl)/rates") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                
                let exchangeRate = try! JSONDecoder().decode(ExchangeRate.self, from: data)
                
                DispatchQueue.main.async {
                    completion(exchangeRate)
                }
            }.resume()
        }
}
