//
//  FlickrPhotoCell.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
    //MARK: Cell Properties
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var downloadingIndicator: UIActivityIndicatorView!
    
    //Mark: UI Configuration
    func updateUI(for photo: Photo) {
        let newImage = try! UIImage(data: Data(contentsOf: photo.photoURL!))
        imageView.image = newImage
    }
}
