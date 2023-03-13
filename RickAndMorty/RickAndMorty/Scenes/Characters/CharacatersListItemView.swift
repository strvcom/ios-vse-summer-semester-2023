//
//  CharacatersListItemView.swift
//  RickAndMorty
//
//  Created by Lukas Smetana on 09.03.2023.
//

import SwiftUI

struct CharacatersListItemView: View {
    let character: Character
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(
                url: character.imageUrl) { image in
                    image
                        .resizable()
                        .frame(width: 110, height: 110)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.appItemLargeTitle)
                    .foregroundColor(.appTextItemTitle)
                    .multilineTextAlignment(.leading)
                
                Text("\(character.species) • \(character.gender)")
                    .font(.appItemDescription)
            }
            .padding(.vertical, 16)
        }
    }
}

struct CharacatersListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CharacatersListItemView(character: Character.mock)
    }
}
