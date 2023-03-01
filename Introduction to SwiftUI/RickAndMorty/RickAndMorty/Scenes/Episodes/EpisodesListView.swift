//
//  EpisodesListView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 01.03.2023.
//

import SwiftUI

struct EpisodesListView: View {
    let episodes: [Episode] = (1...9).map { index in
        Episode(
            id: index,
            name: "Episode #\(index)",
            code: "S01E\(index)",
            airDate: "December \(index), 2013"
        )
    }
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView {
                LazyVStack {
                    ForEach(episodes) { episode in
                        EpisodesListItemView(episode: episode)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
