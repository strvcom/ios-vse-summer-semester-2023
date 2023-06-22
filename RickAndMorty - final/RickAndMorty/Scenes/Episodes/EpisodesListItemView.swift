//
//  EpisodesListItemView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct EpisodesListItemView: View {
    let episode: Episode
    
    var formattedAirDate: String {
        episode.airDate.formatted(
            .dateTime
                .month(.wide)
                .day(.defaultDigits)
                .year()
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(episode.name)
                .font(.appItemLargeTitle)
                .foregroundColor(.appTextItemTitle)
            
            Text("\(episode.code) • \(formattedAirDate)")
                .font(.appItemDescription)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Previews
struct EpisodesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListItemView(episode: .mock)
    }
}
