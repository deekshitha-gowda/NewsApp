# 📰 NewsApp

A modern **SwiftUI-based** news application that delivers the latest news with offline support, dark mode, and smooth UI animations. Built with **MVVM architecture**, it ensures a clean separation of concerns while optimizing performance.

---

## 🚀 Features

✅ **Live News Fetching** - Fetches the latest articles using `NewsAPI`.  
✅ **Offline Support** - Caches news for offline reading.  
✅ **Dark Mode** - Supports system-wide dark/light themes.  
✅ **Animations** - Smooth UI transitions for a better user experience.  
✅ **Save Articles** - Users can bookmark and manage favorite articles.  
✅ **Network Monitoring** - Shows real-time online/offline status.  

---

## 🛠 **Project Setup**

### **1️⃣ Clone the Repository**
```sh

git clone https://github.com/YOUR_GITHUB_USERNAME/NewsApp.git
cd NewsApp

2️⃣ Open the Project in Xcode
Open NewsApp.xcodeproj or NewsApp.xcworkspace.

3️⃣ Install Dependencies (If Needed)
Ensure that required Swift libraries are installed.

4️⃣ Setup API Key
Register at NewsAPI.org to get an API key.
Add the API key in Constants.swift:

struct Constants {
    static let apiKey = "YOUR_NEWS_API_KEY"
}

5️⃣ Run the App
Simulator: Press Cmd + R in Xcode.
iPhone: Connect a device and click Run.

📚 Libraries Used & Their Purpose
SwiftUI	UI - development framework
Combine - Handles async operations
SDWebImageSwiftUI - Caches and loads images efficiently
CoreData - Manages saved articles locally
WebKit - Loads full news articles
Network - Monitor	Checks internet connectivity


🏗 Architecture
The app follows MVVM (Model-View-ViewModel) architecture for better separation of concerns.

Model - Represents data structures like NewsArticle.swift and SavedArticle.swift.
View - SwiftUI views like HomeView, ArticleDetailView, SavedArticlesView.
ViewModel - Handles business logic and API calls (NewsViewModel.swift, SavedArticlesViewModel.swift).
Services - Manages networking, caching, and CoreData storage (APIManager.swift, CoreDataManager.swift).

📜 API Usage
This app uses NewsAPI to fetch news articles.
Make sure to add your own API key in Constants.swift before running the app.

struct Constants {
    static let apiKey = "YOUR_NEWS_API_KEY"
}
