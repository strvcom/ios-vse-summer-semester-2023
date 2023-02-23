//
//  UINavigationController+BackButton.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import UIKit

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
