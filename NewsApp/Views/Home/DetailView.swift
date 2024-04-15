//
//  DetailView.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 16/04/24.
//


import SwiftUI

struct DetailsView: View {
    let headline: Results
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(headline.news_site)
                .foregroundStyle(.red)
            
            Text(convertTimestamp(timestampString: headline.published_at))
                .font(.caption)
                .bold()

            
            Text(headline.title)
                .font(.title2)
                .bold()
            
            Text(headline.summary)
                .font(.callout)
            
            
            Text(headline.news_site)
                .font(.callout)
            
            Text("Author: \(headline.news_site)")
                .font(.caption)
            
            
        }
        .foregroundStyle(.white)
        .multilineTextAlignment(.leading)
        .bold()
        .padding()
    }
}

