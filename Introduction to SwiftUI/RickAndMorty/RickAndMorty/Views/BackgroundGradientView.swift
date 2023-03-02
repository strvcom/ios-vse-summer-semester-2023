//
//  BackgroundGradientView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 01.03.2023.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(
            gradient: .init(
                colors: [
                    .init(red: 0.078, green: 0.078, blue: 0.078),
                    .init(red: 0.122, green: 0.157, blue: 0.192)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
