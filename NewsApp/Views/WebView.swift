//
//  WebView.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    @Binding var loadFailed: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        loadURLWithTimeout(webView: webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private func loadURLWithTimeout(webView: WKWebView) {
        webView.load(URLRequest(url: url))

    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("Started loading.")
            parent.isLoading = true
            parent.loadFailed = false
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finished loading.")
            parent.isLoading = false
            parent.loadFailed = false
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("Failed to load with error: \(error.localizedDescription)")
            parent.isLoading = false
            parent.loadFailed = true
        }
    }
}
