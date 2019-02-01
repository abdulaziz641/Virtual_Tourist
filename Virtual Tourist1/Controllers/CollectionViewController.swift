//
//  CollectionViewController.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit

class CollectionViewController: UIViewController {
    
    //MARK: class properties and outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var receivedPinFromSegue: CLLocationCoordinate2D! = CLLocationCoordinate2D()
    
    let reuseIdentifier = "flickrPhotoCell"
    var pinImagaes: [String] = []
    
    var pinsCreated: [Pin] = []
    
    //Mark: implementing the rquired view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureFlowLayout()
        fetchImages()
    }
    
    //Mark: UI configuration
    func configureFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.width - 2) / 3
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = dimension
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func fetchImages() {
        NetworkClient.searchForImageFromFlickr(nil, lat: self.receivedPinFromSegue.latitude, long: self.receivedPinFromSegue.longitude) { (isSucceeded, _, _, listOfPhotosUrls) in
            if isSucceeded {
                self.pinImagaes = listOfPhotosUrls!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(title: "No images found on this location", message: "No images found on this location", buttonText: "Try Again")
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fetchNewImages(_ sender: Any) {
        showAlert(title: "Fetching New Images", message: "", buttonText: "Ok")
    }
}

