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
    @IBOutlet weak var loadNewImagesButton: UIBarButtonItem!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var receivedPinFromSegue: CLLocationCoordinate2D! = CLLocationCoordinate2D()
    
    var loadingNewImages = false
    
    var pinImagaes: [String] = []
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        receivedPinFromSegue = CLLocationCoordinate2D()
    }
    
    //Mark: UI configuration
    func configureFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.width - 2) / 3
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = dimension
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //MARK: IBActions
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fetchNewImages(_ sender: Any) {
        loadingNewImages = true
        let lat = receivedPinFromSegue.latitude
        let long = receivedPinFromSegue.longitude
        
        NetworkClient.searchForImageFromFlickr([:], lat: lat, long: long) { (isSucceeded, _, _, photosList) in
            if isSucceeded {
                self.pinImagaes = photosList!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(title: "Error", message: "No Images to display", buttonText: "Try Again")
            }
        }
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
}
