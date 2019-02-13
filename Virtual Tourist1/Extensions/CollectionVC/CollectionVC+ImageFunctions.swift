//
//  CollectionVC+ImageFetching.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 03/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension PhotoAlbumViewController {
    
    //MARK: Image Fetching
    func fetchImages() {
        let lat = loadedPinFromStore.latitude
        let long = loadedPinFromStore.longitude
        NetworkClient.searchForImageFromFlickr(nil, lat: lat, long: long) { (isSucceeded, _, _, listOfPhotosUrls) in
            if isSucceeded {
                for url in listOfPhotosUrls ?? [] {
                    self.createNewPhoto(for: self.loadedPinFromStore, and: url)
                }
            }
        }
        DispatchQueue.main.async {
            self.loadNewImagesButton.isEnabled = true
        }
    }
    
    //MARK: creating a new Photo for Pin
    func createNewPhoto(for pin: Pin, and url: String) {
        let newPhoto = Photo(context: appDelegate.dataController.viewContext)
        newPhoto.pin = pin
        newPhoto.latitude = pin.latitude
        newPhoto.longitude = pin.longitude
        newPhoto.photoURL = url
        try? appDelegate.dataController.viewContext.save()
    }
    
    //MARK: remove Photo from store
    func removePhoto(indexPath: IndexPath) {
        let photoToDelete = fetchedResultsController.object(at: indexPath)
        appDelegate.dataController.viewContext.delete(photoToDelete)
        try? appDelegate.dataController.viewContext.save()
    }
}
