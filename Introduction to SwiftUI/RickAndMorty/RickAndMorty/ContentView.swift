//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 01.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EpisodesListView()
            .foregroundColor(
                Color(red: 0.694, green: 0.757, blue: 0.800)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
