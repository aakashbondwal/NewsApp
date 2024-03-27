//
//  ImageView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import SwiftUI


struct ImageView: View {
    
    @StateObject var vm: ImageViewModel
    
    init(articles: Results){
        _vm = StateObject(wrappedValue: ImageViewModel(articles: articles))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if vm.isLoading {
                Text("Loading...")
                    .font(.callout)
                    .bold()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.gray)
            }
        }
    }
}

