//
//  Login.swift
//  OnlineBank
//
//  Created by Paul Olivier on 23/06/2021.
//

import Foundation

class Login: ObservableObject {
    
    @Published var authenticated = false
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(request: LoginRequest, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "\(backUrl)/auth/login") else { return }

        let finalBody = try! JSONEncoder().encode(request)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                let statusCode = response?.statusCode()
                
                if statusCode! == 200 {
                    let response = try! JSONDecoder().decode(LoginResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        //Store token
                        Keychain().store(key: "user", value: String(describing: response))
                        self.authenticated = true
                        completion(self.authenticated)
                        
                    }
                }else {
                    DispatchQueue.main.async {
                        self.authenticated = false
                        completion(self.authenticated)
                    }
                }
            }.resume()
        }
}
