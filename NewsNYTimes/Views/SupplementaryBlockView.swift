//
//  SupplementaryBlockView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 3.06.25.
//

import SwiftUI

struct SupplementaryBlockView: View {
    let block: SupplementaryBlock

    var body: some View {
        VStack(spacing: 10) {
            if let titleSymbol = block.titleSymbol {
                Image(systemName: titleSymbol)
                    .foregroundColor(.blue)
            }
            
            Text(block.title)
                .font(.headline)

            if let subtitle = block.subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Button(action: {}) {
                HStack {
                    if let symbol = block.buttonSymbol {
                        Image(systemName: symbol)
                            .foregroundColor(.blue)
                            .padding()
                    }
                    Spacer()
                    Text(block.buttonTitle)
                        .fontWeight(.bold)
                    Spacer()
                    if let symbol = block.buttonSymbol {
                        Image(systemName: symbol)
                            .padding()
                    }
                }
                .frame(width: 300, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
        }
        .padding()
        .frame(width: 361, height: 144)
        .background(.white)
        .cornerRadius(5)
    }
}
