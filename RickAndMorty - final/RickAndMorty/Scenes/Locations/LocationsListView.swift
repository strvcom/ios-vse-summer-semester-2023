//
//  LocationsListView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct LocationsListView: View {
    @StateObject var store = LocationsListStore()
    
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
        .navigationTitle("Locations")
        .onFirstAppear(perform: load)
    }
    
    @ViewBuilder var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(store.locations) { location in
                    NavigationLink(value: TabRoute.locationDetail(.entity(location))) {
                        LocationsListItemView(location: location)
                    }
                    .task {
                        await loadMoreIfNeeded(for: location)
                    }
                }
            }
            
            if case let .finished(loadingMore) = store.state, loadingMore {
                ProgressView()
            }
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Actions
private extension LocationsListView {
    func load() {
        Task {
            await store.load()
        }
    }
    
    func loadMoreIfNeeded(for location: Location) async {
        await store.loadMoreIfNeeded(for: location)
    }
}

// MARK: - Previews
struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
