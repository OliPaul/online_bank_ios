//
//  URLResponseExt.swift
//  OnlineBank
//
//  Created by Paul Olivier on 24/06/2021.
//

import Foundation

extension URLResponse {

    func statusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
