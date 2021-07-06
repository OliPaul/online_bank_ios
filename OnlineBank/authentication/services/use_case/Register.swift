//
//  Register.swift
//  OnlineBank
//
//  Created by Paul Olivier on 27/06/2021.
//

import Foundation

class Register: ObservableObject {
    
    @Published var registered = false
    var backUrl = ProcessInfo.processInfo.environment["BACK_URL"] ?? ""

    func execute(request: RegisterRequest, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "\(backUrl)/auth/register") else { return }

        let finalBody = try! JSONEncoder().encode(request)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = finalBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = response?.statusCode()
                
                if statusCode! == 200 {
                    
                    DispatchQueue.main.async {
                        
                        self.registered = true
                        completion(self.registered)
                        
                    }
                }else {
                    DispatchQueue.main.async {
                        self.registered = false
                        completion(self.registered)
                    }
                }
            }.resume()
        }
}

