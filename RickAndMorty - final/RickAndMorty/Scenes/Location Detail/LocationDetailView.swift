//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SwiftUI

struct LocationDetailView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @StateObject var store: LocationDetailStore
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()
            
            switch (store.state, store.location) {
            case (.finished, .some(let location)):
                makeContent(for: location)
            case (.initial, _), (.loading, _), (.finished, _):
                ProgressView()
            case (.failed, _):
                Text("😢 Something went wrong")
            }
        }
        .navigationTitle(store.location?.name ?? "Loading...")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: toggleLike) {
                        Image(
                            systemName: store.isLiked ? "heart.fill" : "heart"
                        )
                    }
                    
                    ShareButton(url: router.deeplinkURL)
                }
            }
        }
        .onFirstAppear(perform: load)
    }
    
    @ViewBuilder var characters: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Residents")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
                .padding(.leading, 8)
            
            VStack(spacing: 8) {
                ForEach(store.residents) { resident in
                    NavigationLink(value: TabRoute.characterDetail(.entity(resident))) {
                        LocationDetailResidentView(resident: resident)
                    }
                }
            }
        }
    }
    
    @ViewBuilder func makeContent(for location: Location) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                makeInfo(for: location)
                
                characters
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
    }
    
    @ViewBuilder func makeInfo(for location: Location) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            VStack(alignment: .horizontalInfoAlignment, spacing: 8) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "info.circle")
                    
                    Text(location.name)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "globe")
                    
                    Text(location.type)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "rays")
                    
                    Text(location.dimension)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
            }
            .font(.appItemDescription)
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Actions
private extension LocationDetailView {
    func load() {
        Task {
            await store.load()
        }
    }
    
    func toggleLike() {
        Task {
            await store.toggleLike()
        }
    }
}

// MARK: - Previews
struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(
            store: .init(providedData: .entity(.mock))
        )
    }
}
