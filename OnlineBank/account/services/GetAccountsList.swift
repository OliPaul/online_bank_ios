//
//  GetAccountsList.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import Foundation

class GetAccountsList: ObservableObject {
    
    @Published var accounts = [Account]()
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(completion: @escaping ([Account]) -> ()) {
        let userString: Data? = Keychain().get(key: "user")
        let user = try! JSONDecoder().decode(LoginResponse.self, from: userString!)
        guard let url = URL(string: "\(backUrl)/customer/accounts/\(user.id)") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                let statusCode = response?.statusCode()
                
                if statusCode! == 200 {
                    let accounts = try! JSONDecoder().decode([Account].self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(accounts)
                    }
                }else {
                    DispatchQueue.main.async {
                        completion(self.accounts)
                    }
                }
            }.resume()
        }
}
