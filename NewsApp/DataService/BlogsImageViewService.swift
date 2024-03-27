//
//  BlogsImageViewService.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 06/01/24.
//
import Foundation
import SwiftUI
import Combine

class BlogsImageViewService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let blogs: BlogResults
    private let fileManager = LocalFileManager.instance
    private let folderName = "blogs_images"
    private let imageName: String
    
    init(blogs: BlogResults) {
        self.blogs = blogs
        self.imageName = String(blogs.id)
        getImage()
        
    }
    
    
    private func getImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from file manager.")
        } else {
            downloadImage()
            print("Downloading Image.")
        }
    }
    
    
    private func downloadImage() {
        
        guard let url = URL(string: blogs.image_url) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName , folderName: self.folderName)
            })
        
    }
    
}
