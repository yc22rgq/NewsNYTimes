//
//  APIService.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    private let baseURL = "https://us-central1-server-side-functions.cloudfunctions.net"
    private let autorizationHeader = "eduard-danchenko"
    
    func fetchArticles(period: Int) -> AnyPublisher<[Article], Error> {
        guard let url = URL(string: "\(baseURL)/nytimes?period=\(period)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue(autorizationHeader, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ArticlesResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
    
    func fetchSupplementaryBlocks() -> AnyPublisher<[SupplementaryBlock], Error> {
        guard let url = URL(string: "\(baseURL)/supplementary") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue(autorizationHeader, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SupplementaryResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .eraseToAnyPublisher()
    }
}

struct ArticlesResponse: Decodable {
    let results: [Article]
}

struct SupplementaryResponse: Decodable {
    let results: [SupplementaryBlock]
}
