//
//  NavigationRoute.swift
//  RickAndMorty
//
//  Created by Matej Molnár on 26.10.2022.
//

import Foundation

protocol NavigationRoute: Hashable {
    static func path(from pathComponents: [String]) -> [Self]?
}
