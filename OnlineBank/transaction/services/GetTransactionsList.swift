//
//  GetTransactionsList.swift
//  OnlineBank
//
//  Created by Paul Olivier on 28/06/2021.
//

import Foundation

class GetTransactionsList: ObservableObject {
    
    @Published var transactions = [Transaction]()
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(completion: @escaping ([Transaction]) -> ()) {
        let userString: Data? = Keychain().get(key: "user")
        let user = try! JSONDecoder().decode(LoginResponse.self, from: userString!)
        guard let url = URL(string: "\(backUrl)/customer/transactions/\(user.id)") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                let statusCode = response?.statusCode()
                
                if statusCode! == 200 {
                    let transactions = try! JSONDecoder().decode([Transaction].self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(transactions)
                    }
                }else {
                    DispatchQueue.main.async {
                        completion(self.transactions)
                    }
                }
            }.resume()
        }
}
