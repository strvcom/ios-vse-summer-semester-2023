//
//  LocationDetailResidentView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SwiftUI

struct LocationDetailResidentView: View {
    let resident: Character
    
    var body: some View {
        HStack(spacing: 16) {
            Text(resident.name)
                .font(.appItemSmallTitle)
                .foregroundColor(.appTextItemTitle)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text("\(resident.species)")
                .font(.appItemDescription)
        }
        .padding(16)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct LocationDetailResidentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailResidentView(resident: .mock)
    }
}
