//
//  LocationsListitemView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct LocationsListItemView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.name)
                .font(.appItemLargeTitle)
                .foregroundColor(.appTextItemTitle)
            
            Text("\(location.type)")
                .font(.appItemDescription)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Previews
struct LocationsListItemView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListItemView(location: .mock)
    }
}
