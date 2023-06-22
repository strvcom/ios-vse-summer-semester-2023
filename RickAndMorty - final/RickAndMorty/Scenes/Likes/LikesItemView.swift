//
//  LikesItemView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SwiftUI

struct LikesItemView: View {
    let like: Like
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(like.name ?? "- unknown -")
                .font(.appItemLargeTitle)
                .foregroundColor(.appTextItemTitle)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appBackgroundItem)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct LikesItemView_Previews: PreviewProvider {
    static var previews: some View {
        LikesItemView(like: .mock)
    }
}
