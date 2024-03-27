//
//  NasaPOTDImageService.swift
//  NewsApp
//
//  Created by Aakash  Bondwal  on 09/03/24.
//

import Foundation
import SwiftUI
import Combine

class NasaPOTDImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let potd: NasaPOTDDataModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "nasaPOTD_images"
    private let imageName: String
    
    init(potd: NasaPOTDDataModel) {
        self.potd = potd
        self.imageName = String(potd.url)
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
        
        guard let url = URL(string: potd.hdurl) else { return }
        
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
