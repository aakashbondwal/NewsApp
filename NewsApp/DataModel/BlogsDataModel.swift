//
//  BlogsDataModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 05/01/24.
//

import Foundation

//Spaceflight Api Blogs
//https://api.spaceflightnewsapi.net/v4/blogs/?limit=100

struct BlogsDataModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [BlogResults]
}

struct BlogResults: Identifiable, Codable {
    let id: Int
    let title: String
    let url: String
    let image_url: String
    let news_site: String
    let summary: String
    let published_at: String
    let updated_at: String
    let featured: Bool
    let launches: [BlogLaunches]
    let events: [BlogEvents]
}

struct BlogLaunches: Codable {
    let launch_id: String
    let provider: String
}

struct BlogEvents: Codable {
    let event_id: Int
    let provider: String
}
