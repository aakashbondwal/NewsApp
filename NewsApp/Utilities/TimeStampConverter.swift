//
//  TimeStampConverter.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//

import Foundation

<<<<<<< HEAD
func convertTimestampToReadableDate(_ timestamp: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.date(from: timestamp) {
        let readableDateFormatter = DateFormatter()
        readableDateFormatter.dateFormat = "MMM d, yyyy - h:mm a"
        return readableDateFormatter.string(from: date)
    } else {
        return "Invalid Date"
=======
func convertTimestamp(timestampString: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    if let date = dateFormatter.date(from: timestampString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy"
        outputFormatter.timeZone = TimeZone.current
        return outputFormatter.string(from: date)
    } else {
        return "Invalid Timestamp"
>>>>>>> bd2b336 (Fix: Replaced Old API service with the new one)
    }
}
