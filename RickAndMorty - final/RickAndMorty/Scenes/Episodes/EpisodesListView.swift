//
//  EpisodesListView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct EpisodesListView: View {
    @StateObject var store = EpisodesListStore()
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            switch store.state {
            case .finished:
                content
            case .initial, .loading:
                ProgressView()
            case .failed:
                Text("😢 Something went wrong")
            }
        }
        .navigationTitle("Episodes")
        .onFirstAppear(perform: load)
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            Group {
                LazyVStack {
                    ForEach(store.episodes) { episode in
                        NavigationLink(value: TabRoute.episodeDetail(.entity(episode))) {
                            EpisodesListItemView(episode: episode)
                        }
                        .task {
                            await loadMoreIfNeeded(for: episode)
                        }
                    }
                }
                
                if case let .finished(loadingMore) = store.state, loadingMore {
                    ProgressView()
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

// MARK: - Actions
private extension EpisodesListView {
    func load() {
        Task {
            await store.load()
        }
    }
    
    func loadMoreIfNeeded(for episode: Episode) async {
        await store.loadMoreIfNeeded(for: episode)
    }
}

// MARK: - Previews
struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
