//
//  BlogsImageView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//


import SwiftUI


struct BlogsImageView: View {
    
    @StateObject var vm: BlogsImageViewModel
    
    init(blogs: BlogResults){
        _vm = StateObject(wrappedValue: BlogsImageViewModel(blogs: blogs))
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
