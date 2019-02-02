//
//  CollectionVC+Delegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import Foundation
import UIKit

extension CollectionViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Mark: Delegate Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return pinImagaes.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoardId.FlickrCellResueIdentifier.rawValue, for: indexPath) as! FlickrPhotoCell
        DispatchQueue.main.async {
            let imageURL = self.pinImagaes[indexPath.row]
            if let imageData = try? Data(contentsOf: URL(string: imageURL)!) {
                cell.imageView.image = UIImage(data: imageData)
                cell.downloadingIndicator.stopAnimating()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let selectedPhoto = appDelegate.pinImagaes[indexPath.row]
        //        showAlert(title: "Selected", message: "selected photo with URL: \(selectedPhoto)", buttonText: "Ok")
    }
}
