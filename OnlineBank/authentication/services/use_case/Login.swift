//
//  Login.swift
//  OnlineBank
//
//  Created by Paul Olivier on 23/06/2021.
//

import Foundation

class Login: ObservableObject {
    
    @Published var authenticated = false

    func execute(request: LoginRequest) {
            guard let url = URL(string: "http://localhost:8089/public/v0/auth/login") else { return }

        let finalBody = try! JSONEncoder().encode(request)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                let resData = try! JSONDecoder().decode(LoginResponse.self, from: data)
                print(resData)
                /*if resData.res == "correct" {
                    DispatchQueue.main.async {
                        self.authenticated = true
                    }
                }*/
            }.resume()
        }
}
