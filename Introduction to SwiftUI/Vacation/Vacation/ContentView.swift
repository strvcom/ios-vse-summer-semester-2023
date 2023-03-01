//
//  ContentView.swift
//  Vacation
//
//  Created by Jan Kaltoun on 01.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    LocationView(
                        image: Image("beach1"),
                        name: "Bali, Indonesia"
                    )
                    
                    LocationView(
                        image: Image("beach2"),
                        name: "McWay Falls, US"
                    )
                    
                    LocationView(
                        image: Image("beach3"),
                        name: "Mácháč, ČR"
                    )
                }
                .padding(.horizontal)
            }
            .navigationTitle("Dream vacations")
        }
    }
}

struct LocationView: View {
    let image: Image
    let name: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.green)
                
                Text(name)
            }
            .font(.caption)
            .fontWeight(.semibold)
            .padding(8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(8)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
        .shadow(
            color: .black.opacity(0.3),
            radius: 8,
            x: 0,
            y: 5
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
