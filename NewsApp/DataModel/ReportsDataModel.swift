//
//  ReportsDataModel.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 05/01/24.
//

import Foundation

//Spaceflight API Reports
//https://api.spaceflightnewsapi.net/v4/reports/?limit=100

struct ReportsDataModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [ReportResults]
}

struct ReportResults: Identifiable, Codable {
    let id: Int
    let title: String
    let url: String
    let image_url: String
    let news_site: String
    let summary: String
    let published_at: String
    let updated_at: String
}
