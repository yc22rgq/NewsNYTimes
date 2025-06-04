//
//  ArticleCardView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 3.06.25.
//

import SwiftUI

struct ArticleCardView: View {
    let article: Article
    let isFavorite: Bool
    let isBlocked: Bool
    let onFavorite: () -> Void
    let onBlocked: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                if let url = URL(string: article.url) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }) {
                AsyncImage(url: URL(string: article.media?.first?.mediaMetadata.last?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().fill(Color.gray.opacity(0.2))
                }
                .aspectRatio(4/3, contentMode: .fill)
                .clipped()
                .cornerRadius(5)
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(article.title)
                        .foregroundColor(.primary)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(article.abstract)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Spacer()
                    Text("\(article.section) • \(article.publishedDate)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            VStack {
                Menu {
                    if isBlocked {
                        Button(role: .destructive, action: onBlocked) {
                            Label("Unblock", systemImage: "lock.open")
                        }
                    } else {
                        if isFavorite {
                            Button(action: onFavorite) {
                                Label("Remove from Favorites", systemImage: "heart.slash")
                            }
                        } else {
                            Button(action: onFavorite) {
                                Label("Add to Favorites", systemImage: "heart")
                            }
                        }
                        
                        Button(role: .destructive, action: onBlocked) {
                            Label("Block", systemImage: "nosign")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .padding(.leading, 8)
                }
                
                Spacer()
            }
        }
        .padding()
        .frame(width: 361, height: 96)
        .background(.white)
        .cornerRadius(5)
    }
}
