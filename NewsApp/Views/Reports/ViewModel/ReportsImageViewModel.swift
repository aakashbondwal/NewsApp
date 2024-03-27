//
//  ReportsImageViewModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation
import SwiftUI
import Combine

class ReportsImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let reports: ReportResults
    private let dataService : ReportsImageViewService
    private var cancellables = Set<AnyCancellable>()
    
    init(reports: ReportResults) {
        self.reports = reports
        self.dataService = ReportsImageViewService(reports: reports)
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
