//
//  CollectionVC+Delegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import Foundation
import UIKit

extension PhotoAlbumViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Mark: Delegate Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int { return (fetchedResultsController.sections?.count)! }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoardId.FlickrCellResueIdentifier.rawValue, for: indexPath) as! FlickrPhotoCell
        let photo = fetchedResultsController.object(at: indexPath)
        if let imageData = photo.photoData, let image = UIImage(data: imageData) {
            cell.imageView.image = image
            cell.downloadingIndicator.stopAnimating()
        } else if let url = URL(string: photo.photoURL ?? "") {
            NetworkClient.downloadImage(url: url) { (isSucceeded, data, errorMessage) in
                guard (isSucceeded == true) else {
                    self.showAlert(title: "Error Downloading Image", message: errorMessage, buttonText: "Try Again")
                    return
                }
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data!)
                    cell.downloadingIndicator.stopAnimating()
                    photo.photoData = data
                    try! self.appDelegate.dataController.viewContext.save()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        removePhoto(indexPath: indexPath)
    }
}
