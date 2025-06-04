//
//  ArticlesViewModel.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import Foundation
import Combine

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var supplementaryBlocks: [SupplementaryBlock] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favorites: Set<Int> = []
    @Published var blocked: Set<Int> = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData() {
        isLoading = true
        errorMessage = nil
        
        let articlesPublisher = APIService.shared.fetchArticles(period: 30)
        let supplementaryPublisher = APIService.shared.fetchSupplementaryBlocks()
        
        Publishers.Zip(articlesPublisher, supplementaryPublisher)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { articles, supplementary in
                self.articles = articles
                self.supplementaryBlocks = supplementary
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(article: Article) {
        if favorites.contains(article.id) {
            favorites.remove(article.id)
        } else {
            favorites.insert(article.id)
        }
    }
    
    func toggleBlocked(article: Article) {
        if blocked.contains(article.id) {
            blocked.remove(article.id)
        } else {
            blocked.insert(article.id)
            if isFavorite(article: article) { favorites.remove(article.id) }
        }
    }
    
    func isFavorite(article: Article) -> Bool {
        favorites.contains(article.id)
    }

    func isBlocked(article: Article) -> Bool {
        blocked.contains(article.id)
    }
}
