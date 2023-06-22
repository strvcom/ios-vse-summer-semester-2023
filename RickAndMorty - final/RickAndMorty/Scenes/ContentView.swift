//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = NavigationRouter()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack(path: $router.charactersPath) {
                CharactersListView()
                    .navigationDestination(for: TabRoute.self) { route in
                        destination(for: route)
                    }
            }
            .tag(Tab.characters)
            .tabItem {
                Image(systemName: "person.2")

                Text("Characters")
            }
            
            NavigationStack(path: $router.episodesPath) {
                EpisodesListView()
                    .navigationDestination(for: TabRoute.self) { route in
                        destination(for: route)
                    }
            }
            .tag(Tab.episodes)
            .tabItem {
                Image(systemName: "film")
                
                Text("Episodes")
            }
            
            NavigationStack(path: $router.locationsPath) {
                LocationsListView()
                    .navigationDestination(for: TabRoute.self) { route in
                        destination(for: route)
                    }
            }
            .tag(Tab.locations)
            .tabItem {
                Image(systemName: "globe.europe.africa")
                
                Text("Locations")
            }
            
            NavigationStack(path: $router.likesPath) {
                LikesView()
                    .navigationDestination(for: TabRoute.self) { route in
                        destination(for: route)
                    }
            }
            .tag(Tab.likes)
            .tabItem {
                Image(systemName: "heart.text.square")
                
                Text("Likes")
            }
        }
        .accentColor(.appTextBody)
        .foregroundColor(.appTextBody)
        .environmentObject(router)
        .preferredColorScheme(.none)
        .onOpenURL { url in
            try? router.executeDeepLink(url: url)
        }
    }
}

private extension ContentView {
    @ViewBuilder
    func destination(for route: TabRoute) -> some View {
        switch route {
        case let .characterDetail(providedData):
            CharacterDetailView(store: .init(providedData: providedData))
        case let .locationDetail(providedData):
            LocationDetailView(store: .init(providedData: providedData))
        case let .episodeDetail(providedData):
            EpisodeDetailView(store: .init(providedData: providedData))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
