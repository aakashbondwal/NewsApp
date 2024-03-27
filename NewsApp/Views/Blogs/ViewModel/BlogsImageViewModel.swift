//
//  BlogsImageViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import SwiftUI
import Combine

class BlogsImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let blogs: BlogResults
    private let dataService : BlogsImageViewService
    private var cancellables = Set<AnyCancellable>()
    
    init(blogs: BlogResults) {
        self.blogs = blogs
        self.dataService = BlogsImageViewService(blogs: blogs)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
