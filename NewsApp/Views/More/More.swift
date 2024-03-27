//
//  Settings.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import SwiftUI

struct More: View {
    
    @State private var showNasaPOTD: Bool = false
    var body: some View {
        
        ScrollView {
            
            
            
            VStack(alignment: .leading, spacing: 10) {
                
                Image("api")
                    .resizable().scaledToFit()
                
                
                
                Text("Following Data is Provided by SpaceFlight News API.")
                    .font(.title)
                    .bold()
                
                Text("I would like to express my gratitude to the Spaceflight News API for providing valuable and up-to-date information related to space exploration. This API has been an invaluable resource, offering a comprehensive and reliable source of news and updates from the ever-evolving world of spaceflight. Its user-friendly interface and well-organized data have significantly contributed to the accessibility of space-related information for developers, researchers, and enthusiasts alike. The dedication of the Spaceflight News API team in maintaining and delivering accurate content has undoubtedly played a crucial role in fostering a deeper understanding and appreciation for the advancements and discoveries within the realm of space exploration. I extend my thanks to the Spaceflight News API for their commendable efforts in making space news easily accessible to the global community.")
                
                Spacer()
            }.padding(.horizontal)
                .multilineTextAlignment(.leading)
        }
        
    }
}

#Preview {
    More()
}
