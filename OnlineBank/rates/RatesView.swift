//
//  RatesView.swift
//  OnlineBank
//
//  Created by Paul Olivier on 07/07/2021.
//

import SwiftUI



struct RatesView: View {
    
    @State private var exchangeRate: ExchangeRate?
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Euro (EUR) - Base")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.EUR ?? 1))
                }
                HStack {
                    Text("Dollar (USD)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.USD ?? 1))
                }
                HStack {
                    Text("Australian Dollar (AUD)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.AUD ?? 1))
                }
                HStack {
                    Text("Bitcoin (BTC)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.BTC ?? 1))
                }
                HStack {
                    Text("Swiss Franc (CHF)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.CHF ?? 1))
                }
                HStack {
                    Text("Canadian Dollar (CAD)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.CAD ?? 1))
                }
                HStack {
                    Text("Livre Sterling (GBP)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.GBP ?? 1))
                }
                HStack {
                    Text("Chinese Yuan (CNY)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.CNY ?? 1))
                }
                HStack {
                    Text("Algerian Dinar (DZD)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.DZD ?? 1))
                }
                HStack {
                    Text("Ouest African Franc (XOF)")
                    Spacer()
                    Text(String(describing: exchangeRate?.rates.XOF ?? 1))
                }
            }
            .onAppear() {
                GetExchangeRate().execute() { exchangeRate in
                    self.exchangeRate = exchangeRate
                }
            }
            Spacer()
            HStack(alignment: .center) {
                Text("source:")
                    .font(.footnote)
                    .italic()
                Button("Fixer.io") {
                    guard let url = URL(string: "https://fixer.io/") else { return }
                    UIApplication.shared.open(url)
                }
                .font(.footnote)
            }
            .padding(.bottom)
            
        }
    }
}

struct RatesView_Previews: PreviewProvider {
    static var previews: some View {
        RatesView()
    }
}
