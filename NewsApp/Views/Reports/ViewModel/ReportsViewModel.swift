//
//  ReportsViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import Combine

class ReportsViewModel: ObservableObject {
    @Published var allReports: ReportsDataModel?
    
    private let dataService = ReportsDataService()
    
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        dataService.$allReports
            .sink { [weak self] returnedReports in
                self?.allReports = returnedReports
            }
            .store(in: &cancellables)
        
    }

}
