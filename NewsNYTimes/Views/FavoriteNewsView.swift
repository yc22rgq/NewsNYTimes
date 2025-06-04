//
//  FavoritiesNewsView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import SwiftUI

struct FavoriteNewsView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    
    var body: some View {
        if viewModel.favorites.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "heart.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.blue)
                
                Text("No Favorite News")
                    .font(.headline)
            }
            .frame(minHeight: UIScreen.main.bounds.height * 0.5)
        } else {
            ForEach(viewModel.articles) { article in
                if viewModel.isFavorite(article: article) {
                    ArticleCardView(article: article,
                                    isFavorite: viewModel.isFavorite(article: article),
                                    isBlocked: viewModel.isBlocked(article: article),
                                    onFavorite: { viewModel.toggleFavorite(article: article) },
                                    onBlocked: { viewModel.toggleBlocked(article: article) })
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    FavoriteNewsView(viewModel: ArticlesViewModel())
}
