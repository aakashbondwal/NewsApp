//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 05/01/24.
//

import Foundation
import Combine
import SwiftUI

class ArticlesViewModel: ObservableObject {
    @Published var allArticles: ArticlesDataModel?
    
    private let dataService = ArticlesDataService()
   
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$allArticles
            .sink { [weak self] returnedArticles in
                self?.allArticles = returnedArticles
            }
            .store(in: &cancellables)
        
    }
    


}
