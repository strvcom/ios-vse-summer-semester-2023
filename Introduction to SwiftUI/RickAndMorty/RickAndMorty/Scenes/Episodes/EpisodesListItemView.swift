//
//  EpisodesListItemView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 01.03.2023.
//

import SwiftUI

struct EpisodesListItemView: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(episode.name)
                .font(.title)
                .foregroundColor(
                    Color(red: 0.902, green: 0.961, blue: 0.984)
                )
            
            Text("\(episode.code) • \(episode.airDate)")
                .font(.caption)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(red: 0.051, green: 0.051, blue: 0.055)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
}

struct EpisodesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListItemView(
            episode: Episode(
                id: 1,
                name: "Pilot",
                code: "S01E01",
                airDate: "December 2, 2013"
            )
        )
    }
}
