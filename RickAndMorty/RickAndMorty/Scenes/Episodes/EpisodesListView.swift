//
//  EpisodesListView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct EpisodesListView: View {
    
    @State var episodes: [Episode] = Episode.mockedEpisodes
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            content
        }
        .navigationTitle("Episodes")
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            Group {
                LazyVStack {
                    ForEach(episodes) { episode in
                        EpisodesListItemView(episode: episode)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

// MARK: - Previews
struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
