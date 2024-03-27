//
//  BlogsDataService.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import Combine

class BlogsDataService {
    
    @Published var allBlogs: BlogsDataModel?
    
    var blogsSubscription: AnyCancellable?
    
    init() {
        
        getBlogs()
        
    }
    
    
    private func getBlogs() {
        
        
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/blogs/?limit=100") else { return }
        
        blogsSubscription = NetworkingManager.download(url: url)
            .decode(type: BlogsDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,receiveValue: { [weak self] (returnedBlogs) in
                self?.allBlogs = returnedBlogs
                self?.blogsSubscription?.cancel()
            })

    }
}
