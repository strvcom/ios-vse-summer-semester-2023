//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
                     NavigationView {
                         Text("CHARACTERS")
                             .font(.appItemLargeTitle)
                     }
                     .navigationViewStyle(StackNavigationViewStyle())
                     .tabItem {
                         Image(systemName: "person.2")

                         Text("Characters")
                     }

                     NavigationView {
                         Text("EPISODES")
                             .font(.appItemLargeTitle)
                     }
                     .navigationViewStyle(StackNavigationViewStyle())
                     .tabItem {
                         Image(systemName: "film")

                         Text("Episodes")
                     }

                     NavigationView {
                         Text("LOCATIONS")
                             .font(.appItemLargeTitle)
                     }
                     .navigationViewStyle(StackNavigationViewStyle())
                     .tabItem {
                         Image(systemName: "globe.europe.africa")

                         Text("Locations")
                     }

                     NavigationView {
                         Text("LIKES")
                             .font(.appItemLargeTitle)
                     }
                     .navigationViewStyle(StackNavigationViewStyle())
                     .tabItem {
                         Image(systemName: "heart.text.square")

                         Text("Likes")
                     }
                 }
                 .foregroundColor(.appTextBody)
                 .preferredColorScheme(.none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
