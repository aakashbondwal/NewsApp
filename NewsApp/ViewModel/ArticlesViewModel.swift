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
    
    private var dataService : ArticlesDataService
   
    private var cancellables = Set<AnyCancellable>()
    init(selectData: String) {
        self.dataService = ArticlesDataService(selectData: selectData)
        
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$allArticles
            .sink { [weak self] returnedArticles in
                self?.allArticles = returnedArticles
            }
            .store(in: &cancellables)
        
    }
    
    
    func updateData(for selectData: String) {
        cancellables.forEach { $0.cancel() }
        
        dataService = ArticlesDataService(selectData: selectData)
        
        addSubscribers()
    }
    
    


}
