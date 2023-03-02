//
//  Alignment+Custom.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SwiftUI

extension HorizontalAlignment {
    struct HorizontalInfoAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.leading]
        }
    }
    
    static let horizontalInfoAlignment: HorizontalAlignment = HorizontalAlignment(HorizontalInfoAlignment.self)
}
