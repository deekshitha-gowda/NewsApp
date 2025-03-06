//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Deekshitha  on 06/03/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
    }
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveArticle(_ article: NewsArticle) {
        let context = container.viewContext
        let savedArticle = SavedArticle(context: context)
        savedArticle.id = UUID()
        savedArticle.title = article.title
        savedArticle.desc = article.description
        savedArticle.url = article.url
        savedArticle.imageUrl = article.urlToImage
        
        do {
            try context.save()
        } catch {
            print("Error saving article: \(error)")
        }
    }
    
    func fetchSavedArticles() -> [SavedArticle] {
        let context = container.viewContext
        let request: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func deleteArticle(_ article: NewsArticle) {
        let fetchRequest: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", article.url)
        
        do {
            let articles = try context.fetch(fetchRequest)
            for savedArticle in articles {
                context.delete(savedArticle)
            }
            try context.save()
        } catch {
            print("Failed to delete article: \(error.localizedDescription)")
        }
    }
    
    // Cache API News Separately
    func cacheNews(_ articles: [NewsArticle]) {
        DispatchQueue.main.async {
            self.clearCachedNews()
            articles.forEach { article in
                let cachedArticle = CachedNewsArticle(context: self.context)
                cachedArticle.title = article.title
                cachedArticle.desc = article.description
                cachedArticle.url = article.url
                cachedArticle.urlToImage = article.urlToImage
                cachedArticle.publishedAt = Date()
            }
            do {
                try self.context.save()
            } catch {
                print("Failed to cache news: \(error.localizedDescription)")
            }
        }
    }
    
    //Fetch Cached News for Offline Mode
    func fetchCachedNews() -> [NewsArticle] {
        let fetchRequest: NSFetchRequest<CachedNewsArticle> = CachedNewsArticle.fetchRequest()
        
        do {
            let cachedArticles = try context.fetch(fetchRequest)
            return cachedArticles.map { cached in
                NewsArticle(
                    title: cached.title ?? "",
                    description: cached.desc ?? "",
                    urlToImage: cached.urlToImage ?? "", url: cached.url ?? "" ,
                    publishedAt: DateFormatter.localizedString(from: cached.publishedAt ?? Date(), dateStyle: .medium, timeStyle: .short)
                )
            }
        } catch {
            print("Failed to fetch cached news: \(error.localizedDescription)")
            return []
        }
    }
    
    //Clear Cached News
    private func clearCachedNews() {
        let fetchRequest: NSFetchRequest<CachedNewsArticle> = CachedNewsArticle.fetchRequest()
        
        do {
            let cachedArticles = try context.fetch(fetchRequest)
            for article in cachedArticles {
                context.delete(article)
            }
            try context.save()
        } catch {
            print("Failed to clear cached news: \(error.localizedDescription)")
        }
    }
}
