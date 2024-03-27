//
//  ReportsImageView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//


import SwiftUI


struct ReportsImageView: View {
    
    @StateObject var vm: ReportsImageViewModel
    
    init(reports: ReportResults){
        _vm = StateObject(wrappedValue: ReportsImageViewModel(reports: reports))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.gray)
            }
        }
    }
}
