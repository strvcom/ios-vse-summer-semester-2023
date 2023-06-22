//
//  LikesView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct LikesView: View {
    @StateObject var store = LikesStore()
    
    @State private var selectedSection: LikeType = .character
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()
            
            VStack(spacing: 16) {
                Picker("Like type", selection: $selectedSection) {
                    ForEach(LikeType.allCases) { likeType in
                        Text(likeType.title)
                            .tag(likeType)
                    }
                }
                .pickerStyle(.segmented)
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        switch selectedSection {
                        case .character:
                            characters
                        case .episode:
                            episodes
                        case .location:
                            locations
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Likes")
        .onAppear(perform: load)
    }
    
    @ViewBuilder var characters: some View {
        ForEach(store.characters) { character in
            NavigationLink(value: TabRoute.characterDetail(.id(Int(character.itemId)))) {
                LikesItemView(like: character)
            }
        }
    }
    
    @ViewBuilder var episodes: some View {
        ForEach(store.episodes) { episode in
            NavigationLink(value: TabRoute.episodeDetail(.id(Int(episode.itemId)))) {
                LikesItemView(like: episode)
            }
        }
    }
    
    @ViewBuilder var locations: some View {
        ForEach(store.locations) { location in
            NavigationLink(value: TabRoute.locationDetail(.id(Int(location.itemId)))) {
                LikesItemView(like: location)
            }
        }
    }
}

// MARK: - Action
extension LikesView {
    func load() {
        store.updateContent()
    }
}

// MARK: - Previews
struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView()
    }
}
