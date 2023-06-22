//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersListView: View {
    @StateObject var store = CharactersListStore()
    
    @State private var mode: Mode = .list
    
    let gridColumns: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: 10),
        count: 3
    )
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            switch store.state {
            case .finished:
                content
            case .initial, .loading:
                ProgressView()
            case .failed:
                Text("😢 Something went wrong")
            }
        }
        .navigationTitle("Characters")
        .toolbar {
            ToolbarItem {
                Button(action: toggleMode) {
                    mode.image
                }
            }
        }
        .onFirstAppear(perform: load)
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            switch mode {
            case .list:
                listContent
            case .grid:
                gridContent
            }
            
            if case let .finished(loadingMore) = store.state, loadingMore {
                ProgressView()
            }
        }
    }
    
    @ViewBuilder var listContent: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(store.characters) { character in
                NavigationLink(value: TabRoute.characterDetail(.entity(character))) {
//                    CharactersListRowItemView(character: character)
                    WebImage(url: character.imageUrl)
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFill()
                    Text("\(character.name)")
                        .foregroundColor(.white)
                        .font(.appItemLargeTitle)
                }
                .task {
                    await loadMoreIfNeeded(for: character)
                }
            }
        }
        .padding(.horizontal, 16)
        .transition(.fade)
    }
    
    @ViewBuilder var gridContent: some View {
        LazyVGrid(columns: gridColumns, spacing: 10) {
            ForEach(store.characters) { character in
                NavigationLink(value: TabRoute.characterDetail(.entity(character))) {
                    CharactersListGridItemView(character: character)
                }
                .task {
                    await loadMoreIfNeeded(for: character)
                }
            }
        }
        .padding(.horizontal, 10)
        .transition(.fade)
    }
}

// MARK: - Actions
private extension CharactersListView {
    func load() {
        Task {
            await store.load()
        }
    }
    
    func loadMoreIfNeeded(for character: Character) async {
        await store.loadMoreIfNeeded(for: character)
    }
    
    func toggleMode() {
        withAnimation {
            mode.toggle()
        }
    }
}

// MARK: - Mode
extension CharactersListView {
    enum Mode {
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

// MARK: - Previews
struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
