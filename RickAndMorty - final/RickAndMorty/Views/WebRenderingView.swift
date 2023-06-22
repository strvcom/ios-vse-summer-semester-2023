//
//  WebRenderingView.swift
//  RickAndMorty
//
//  Created by Jan Schwarz on 30.03.2022.
//

import SwiftUI
import WebKit

struct WebRenderingView: UIViewRepresentable {
    let url: URL
    @Binding var isLoaded: Bool
 
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.navigationDelegate = context.coordinator

        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebRenderingView
        
        init(parent: WebRenderingView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoaded = true
        }
    }
}
