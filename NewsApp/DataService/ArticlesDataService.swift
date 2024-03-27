//
//  NewsDataService.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 04/01/24.
//https://api.spaceflightnewsapi.net/v4/articles/?limit=100

import Foundation
import Combine

class ArticlesDataService {
    
    @Published var allArticles: ArticlesDataModel?
    
    var articleSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        
        
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/articles/?limit=100") else { return }
        
        articleSubscription = NetworkingManager.download(url: url)
            .decode(type: ArticlesDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,receiveValue: { [weak self] (returnedArticles) in
                self?.allArticles = returnedArticles
                self?.articleSubscription?.cancel()
            })
        

    }
}
