//
//  ContentView.swift
//  NewsNYTimes
//
//  Created by Эдуард Кудянов on 30.05.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    enum Section: String, CaseIterable, Identifiable {
        case allNews = "All"
        case favoriteNews = "Favorites"
        case blockedNews = "Blocked"
        
        var id: Self { self }
    }
    @State private var selectedSection: Section = .allNews
    
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Section", selection: $selectedSection) {
                    ForEach(Section.allCases) { section in
                        Text(section.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                switch selectedSection {
                case .allNews:
                    AllNewsView(viewModel: viewModel)
                case .favoriteNews:
                    FavoriteNewsView(viewModel: viewModel)
                case .blockedNews:
                    BlockedNewsView(viewModel: viewModel)
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.fetchData()
            }
            .refreshable {
                viewModel.fetchData()
            }
            .background(Color(red: 0.953, green: 0.961, blue: 0.969))
        }
    }
}

#Preview {
    ContentView()
}
