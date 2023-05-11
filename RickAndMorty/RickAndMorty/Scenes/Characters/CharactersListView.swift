//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Lukas Smetana on 09.03.2023.
//

import SwiftUI

struct CharactersListView: View {
    
    @StateObject var viewModel = CharacterListViewModel()
    
    @State private var displayMode: DisplayMode = .list
    
    let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    func makeList() -> some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(id: character.id))) {
                    CharacatersListItemView(character: character)
                }
                .task {
                    await viewModel.fetchMoreIfNeeded(for: character)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    func makeGrid() -> some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(id: character.id))) {
                    CharactersGridItemView(character: character)
                }
                .task {
                    await viewModel.fetchMoreIfNeeded(for: character)
                }
            }
        }
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            ScrollView {
                switch viewModel.state {
                case .initial, .loading:
                    ProgressView()
                case .fetched(let loadingMore):
                    switch displayMode {
                    case .list:
                        makeList()
                    case .grid:
                        makeGrid()
                    }
                    
                    if loadingMore {
                        ProgressView()
                    }
                case .failed:
                    Text("Something went wrong 😕")
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
        }.onFirstAppear {
            Task {
                await viewModel.load()
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
