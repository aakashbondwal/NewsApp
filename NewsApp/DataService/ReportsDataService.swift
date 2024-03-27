//
//  ReportsDataService.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import Combine

class ReportsDataService {
    @Published var allReports: ReportsDataModel?
    
    var reportsSubscription: AnyCancellable?
    
    init() {
        
        getReports()
        
    }
    
    
    private func getReports() {
        
        
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v4/reports/?limit=100") else { return }
        
        reportsSubscription = NetworkingManager.download(url: url)
            .decode(type: ReportsDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,receiveValue: { [weak self] (returnedReports) in
                self?.allReports = returnedReports
                self?.reportsSubscription?.cancel()
            })

    }
}
