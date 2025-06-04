//
//  AllNewsView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 2.06.25.
//

import SwiftUI

struct AllNewsView: View {
    @ObservedObject var viewModel: ArticlesViewModel
    
    @State private var showAlert = false
    
    var body: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
            Spacer()
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(.blue)
                
                Text("No Results")
                    .font(.headline)
                
                Button(action: {
                    viewModel.fetchData()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                        Spacer()
                        Text("Refresh")
                            .bold()
                        Spacer()
                        Image(systemName: "arrow.clockwise")
                    }
                    .padding()
                }
                .frame(width: 300, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(5)
            }
            .frame(minHeight: UIScreen.main.bounds.height * 0.5)
            .onAppear {
                showAlert.toggle()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(errorMessage)
                )
            }
        } else {
            if viewModel.articles.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.blue)
                    
                    Text("No Results")
                        .font(.headline)
                    
                    Button(action: {
                        viewModel.fetchData()
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.blue)
                            Spacer()
                            Text("Refresh")
                                .bold()
                            Spacer()
                            Image(systemName: "arrow.clockwise")
                        }
                        .padding()
                    }
                    .frame(width: 300, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
                .frame(minHeight: UIScreen.main.bounds.height * 0.5)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.articles.indices, id: \.self) { i in
                        let article = viewModel.articles[i]
                        
                        if i != 0 && i % 3 == 0 {
                            let blockIndex = i / 3
                            SupplementaryBlockView(block: viewModel.supplementaryBlocks[blockIndex % 3])
                                .padding(.horizontal)
                        }
                        
                        if !viewModel.isBlocked(article: article) {
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
    }
}

#Preview {
    AllNewsView(viewModel: ArticlesViewModel())
}
