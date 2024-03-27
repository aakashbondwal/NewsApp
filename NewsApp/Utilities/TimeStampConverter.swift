//
//  TimeStampConverter.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation

func convertTimestampToReadableDate(_ timestamp: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.date(from: timestamp) {
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateFormat = "MMM d, yyyy - h:mm a"
        return readableDateFormatter.string(from: date)
    } else {
        return "Invalid Date"
    }
}
