//
//  Article.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import Foundation

struct Article: Identifiable, Codable {
    let id: Int
    let title: String
    let abstract: String
    let url: String
    let publishedDate: String
    let section: String
    let media: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case id = "asset_id"
        case title
        case abstract
        case url
        case publishedDate = "published_date"
        case section
        case media
    }
}

struct Media: Codable {
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
}
