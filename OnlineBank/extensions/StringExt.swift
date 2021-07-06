//
//  StringExt.swift
//  OnlineBank
//
//  Created by Paul Olivier on 24/06/2021.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fr")
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.dateFormat = format
            let date = dateFormatter.date(from: self)

            return date

        }
}
