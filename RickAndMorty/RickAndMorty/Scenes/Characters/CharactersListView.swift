//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Lukas Smetana on 09.03.2023.
//

import SwiftUI

struct CharactersListView: View {
    let characters: [Character] = Character.characters
    @State private var displayMode: DisplayMode = .list
    
    let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView {
                switch displayMode {
                case .list:
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharacatersListItemView(character: character)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                case .grid:
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                CharactersGridItemView(character: character)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .navigationTitle("Characters")
        .toolbar {
            ToolbarItem {
                Button {
                    toggleDisplayMode()
                } label: {
                    displayMode.image
                }
            }
        }
    }
    
    func toggleDisplayMode() {
        withAnimation {
            displayMode.toggle()
        }
    }
}

extension CharactersListView {
    enum DisplayMode {
        case list
        case grid
        
        var image: Image {
            switch self {
            case .list:
                return Image(systemName: "square.grid.3x3")

            case .grid:
                return Image(systemName: "list.dash")
            }
        }
        
        mutating func toggle() {
            switch self {
            case .list:
                self = .grid
            case .grid:
                self = .list
            }
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
