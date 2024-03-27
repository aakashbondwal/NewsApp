//
//  ImageViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let articles: Results
    private let dataService : ImageViewService
    private var cancellables = Set<AnyCancellable>()
    
    init(articles: Results) {
        self.articles = articles
        self.dataService = ImageViewService(articles: articles)
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
