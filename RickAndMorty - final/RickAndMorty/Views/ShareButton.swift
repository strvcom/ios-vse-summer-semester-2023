//
//  ShareButton.swift
//  RickAndMorty
//
//  Created by Matej Molnár on 27.10.2022.
//

import SwiftUI
import UIKit

struct ShareButton<Label>: View where Label: View {
    private let activityItems: [Any]
    private let completion: UIActivityViewController.CompletionWithItemsHandler?
    private let label: () -> Label
    
    @State private var isPresented = false
    
    init(
        url: URL?,
        completion: UIActivityViewController.CompletionWithItemsHandler? = nil,
        label: @escaping () -> Label = { Image(systemName: "square.and.arrow.up") }
    ) {
        self.activityItems = [url ?? ""]
        self.completion = completion
        self.label = label
    }
    
    var body: some View {
        Button(
            action: {
                isPresented = true
            },
            label: label
        )
        .background(
            UIKitActivityView(
                isPresented: $isPresented,
                completion: completion,
                activityItems: activityItems
            )
        )
    }
}

private struct UIKitActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    let completion: UIActivityViewController.CompletionWithItemsHandler?
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard isPresented && uiViewController.presentedViewController == nil else {
            return
        }
        
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = uiViewController.view
        activityViewController.completionWithItemsHandler = { (activityType, success, items, error) in
            isPresented = false
            completion?(activityType, success, items, error)
        }
        
        uiViewController.present(activityViewController, animated: true)
    }
}
