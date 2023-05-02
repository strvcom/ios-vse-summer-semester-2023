//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Jan Kodeš on 16.03.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()

            ScrollView {
                VStack(spacing: 16) {
                    switch viewModel.state {
                    case .initial:
                        ProgressView()
                    case .loading:
                        ProgressView()
                    case .fetched:
                        if let character = viewModel.character {
                            makeImage(url: character.imageUrl)
                            makeInfo(character: character)
                        }
                        
                    case .failed:
                        Text("Sorry character fetch failed")
                    }
                    
                    makeEpisodes()
                }
            }
        }
        .navigationTitle(viewModel.character?.name ?? "")
        .onFirstAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }
}

private extension CharacterDetailView {
    func makeImage(url: URL?) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }

    func makeInfo(character: Character) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    makeInfoRow(title: character.name, iconName: "creditcard")
                    makeInfoRow(title: character.species, iconName: "person.fill.questionmark")

                    if !character.type.isEmpty {
                        makeInfoRow(title: character.type, iconName: "person.fill.viewfinder")
                    }
                    makeInfoRow(title: character.gender, iconName: "person.and.arrow.left.and.arrow.right")
                }

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    makeInfoRow(title: character.location.name, iconName: "globe")
                    makeInfoRow(title: character.origin.name, iconName: "eyes")
                }

            }
        }
        .padding(.horizontal, 8)
    }

    func makeInfoRow(title: String, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)

            Text(title)
        }
        .font(.appItemDescription)
        .foregroundColor(.appTextBody)
    }

    func makeEpisodes() -> some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)

            ForEach(viewModel.episodes) { episode in
                NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                    makeEpisodeRow(episode: episode)
                }
            }
        }
        .padding(.horizontal, 8)
    }

    func makeEpisodeRow(episode: Episode) -> some View {
        HStack {
            Text(episode.name)
                .font(.appItemDescription)
                .foregroundColor(.appTextItemTitle)

            Spacer()

            Text(episode.code)
                .font(.appItemDescription)
                .foregroundColor(.appTextBody)
        }
        .padding(16)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CharacterDetailView(viewModel: CharacterDetailViewModel(id: 1))
        }
    }
}
