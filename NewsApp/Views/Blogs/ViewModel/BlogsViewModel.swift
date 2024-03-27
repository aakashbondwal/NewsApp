//
//  BlogsViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import Combine

class BlogsViewModel: ObservableObject {
    @Published var allBlogs: BlogsDataModel?
    
    private let dataService = BlogsDataService()
    
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$allBlogs
            .sink { [weak self] returnedBlogs in
                self?.allBlogs = returnedBlogs
            }
            .store(in: &cancellables)
        
    }

}
