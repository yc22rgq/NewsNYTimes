//
//  BlockedNewsView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import SwiftUI

struct BlockedNewsView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    
    var body: some View {
        if viewModel.blocked.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "nosign")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.blue)
                
                Text("No Blocked News")
                    .font(.headline)
            }
            .frame(minHeight: UIScreen.main.bounds.height * 0.5)
        } else {
            ForEach(viewModel.articles) { article in
                if viewModel.isBlocked(article: article) {
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
    BlockedNewsView(viewModel: ArticlesViewModel())
}
