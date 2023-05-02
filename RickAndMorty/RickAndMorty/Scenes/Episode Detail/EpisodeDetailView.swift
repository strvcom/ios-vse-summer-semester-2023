//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Jan Kodeš on 15.03.2023.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode

    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    makeInfo(episode: episode)

                    makeCharacters()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 16)
            }
        }
        .navigationTitle(episode.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let url = episode.rottenTomatoesUrl {
                    ShareLink(item: url)
                }
            }
        }
    }
}

private extension EpisodeDetailView {
    func makeCharacters() -> some View {
        VStack(alignment: .leading) {
            Text("Appearing Characters")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
                .padding(.horizontal, 8)

            ForEach(Character.characters) { character in
                NavigationLink(destination: CharacterDetailView(viewModel: .init())) {
                    makeCharacterRow(character: character)
                }
            }
        }
    }

    func makeCharacterRow(character: Character) -> some View {
        HStack {
            Text(character.name)
                .font(.appItemDescription)
                .foregroundColor(.appTextItemTitle)

            Spacer()

            Text(character.species)
                .font(.appItemDescription)
                .foregroundColor(.appTextBody)
        }
        .padding(16)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    func makeInfo(episode: Episode) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)

            makeInfoRow(title: episode.name, iconName: "info.circle")
            makeInfoRow(title: episode.code, iconName: "film")
            makeInfoRow(
                title: episode.airDate.formatted(
                    .dateTime
                        .month(.wide)
                        .day(.defaultDigits)
                        .year()
                ),
                iconName: "play.tv"
            )
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
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EpisodeDetailView(episode: .mock)
        }
    }
}
