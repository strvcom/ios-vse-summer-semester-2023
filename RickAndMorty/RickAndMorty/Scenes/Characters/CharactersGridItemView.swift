//
//  CharactersGridItemView.swift
//  RickAndMorty
//
//  Created by Lukas Smetana on 12.03.2023.
//

import SwiftUI

struct CharactersGridItemView: View {
    let character: Character
    
    var body: some View {
        AsyncImage(
            url: character.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } placeholder: {
                ProgressView()
            }
    }
}

struct CharactersGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersGridItemView(character: Character.mock)
    }
}
