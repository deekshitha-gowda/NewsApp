//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Deekshitha on 06/03/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private let apiKey = "8da51d861d2f4905aa56aa7b5423ba65"
    private let baseURL = "https://newsapi.org/v2/everything"

    private init() {}

    func fetchNews(for category: String, completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(category)&apiKey=\(apiKey)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 500, userInfo: nil)))
                return
            }

            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.articles))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
