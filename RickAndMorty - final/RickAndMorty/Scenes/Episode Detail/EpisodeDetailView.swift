//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SwiftUI

struct EpisodeDetailView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @StateObject var store: EpisodeDetailStore
    
    @State private var isRottenTomatoesShowing = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()
            
            switch (store.state, store.episode) {
            case (.finished, .some(let episode)):
                makeContent(for: episode)
            case (.initial, _), (.loading, _), (.finished, _):
                ProgressView()
            case (.failed, _):
                Text("😢 Something went wrong")
            }
        }
        .navigationTitle(store.episode?.name ?? "Loading...")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    if store.episode?.rottenTomatoesUrl != nil {
                        Button(action: showRottenTomatoes) {
                            Image(systemName: "safari")
                        }
                    }
                    
                    Button(action: toggleLike) {
                        Image(
                            systemName: store.isLiked ? "heart.fill" : "heart"
                        )
                    }
                    
                    ShareButton(url: router.deeplinkURL)
                }
            }
        }
        .sheet(isPresented: $isRottenTomatoesShowing) {
            if let url = store.episode?.rottenTomatoesUrl {
                WebView(url: url)
            } else {
                webViewError
            }
        }
        .onFirstAppear(perform: load)
    }
    
    @ViewBuilder var characters: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Appearing characters")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
                .padding(.leading, 8)
            
            VStack(spacing: 8) {
                ForEach(store.characters) { character in
                    NavigationLink(value: TabRoute.characterDetail(.entity(character))) {
                        EpisodeDetailCharacterView(character: character)
                    }
                }
            }
        }
    }
    
    @ViewBuilder func makeContent(for episode: Episode) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                makeInfo(for: episode)
                
                characters
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder func makeInfo(for episode: Episode) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            VStack(alignment: .horizontalInfoAlignment, spacing: 8) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "info.circle")
                    
                    Text(episode.name)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "film")
                    
                    Text(episode.code)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "play.tv")
                    
                    Text(
                        episode.airDate.formatted(
                            .dateTime
                                .month(.wide)
                                .day(.defaultDigits)
                                .year()
                        )
                    )
                    .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
            }
            .font(.appItemDescription)
        }
        .padding(.horizontal, 8)
    }
    
    @ViewBuilder var webViewError: some View {
        ZStack {
            BackgroundGradientView()
            
            Text("😢 Something went wrong")
        }
    }
}

// MARK: - Actions
private extension EpisodeDetailView {
    func load() {
        Task {
            await store.load()
        }
    }
    
    func toggleLike() {
        Task {
            await store.toggleLike()
        }
    }
    
    func showRottenTomatoes() {
        isRottenTomatoesShowing = true
    }
}

// MARK: - Previews
struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailView(
            store: .init(providedData: .entity(.mock))
        )
    }
}
