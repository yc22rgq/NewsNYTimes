//
//  SupplementaryBlock.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import Foundation

struct SupplementaryBlock: Identifiable, Codable {
    let id: Int
    let titleSymbol: String?
    let title: String
    let subtitle: String?
    let buttonTitle: String
    let buttonSymbol: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case titleSymbol = "title_symbol"
        case title
        case subtitle
        case buttonTitle = "button_title"
        case buttonSymbol = "button_symbol"
    }
}
