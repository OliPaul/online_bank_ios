//
//  Pay.swift
//  OnlineBank
//
//  Created by Paul Olivier on 19/07/2021.
//

import Foundation

class Pay: ObservableObject {
    
    @Published var success = false
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(request: TransactionRequest, completion: @escaping (Bool) -> ()) {
        let userString: Data? = Keychain().get(key: "user")
        let user = try! JSONDecoder().decode(LoginResponse.self, from: userString!)
        guard let url = URL(string: "\(backUrl)/customer/payment") else { return }
        
        var transactionRequest = request
        transactionRequest.userId = String(describing: user.id)

        let finalBody = try! JSONEncoder().encode(transactionRequest)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                let statusCode = response?.statusCode()
                
                if statusCode! == 200 {
                    _ = try! JSONDecoder().decode(Transaction.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.success = true
                        completion(self.success)
                        
                    }
                }else {
                    DispatchQueue.main.async {
                        self.success = false
                        completion(self.success)
                    }
                }
            }.resume()
        }
}
