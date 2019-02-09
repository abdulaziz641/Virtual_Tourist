//
//  PhotoAlbumViewController.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController {
    
    //MARK: class properties and outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadNewImagesButton: UIBarButtonItem!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var receivedPinFromSegue: CLLocationCoordinate2D! = CLLocationCoordinate2D()
    
    var loadedPinFromStore: Pin!
    var loadingNewImages = false
    
    var isEditingImages = false
    
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    
    //Mark: implementing the rquired view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editingConfiguration()
        configureFlowLayout()
        fetchImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        receivedPinFromSegue = CLLocationCoordinate2D()
    }
    
    //MARK: IBActions
    @objc func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: IBActions
    @objc func editImages(_ sender: Any) {
        isEditingImages = !isEditingImages
        editingConfiguration()
    }
    
    @IBAction func fetchNewImages(_ sender: Any) {
        loadingNewImages = !loadingNewImages
        for photo in fetchedResultsController.fetchedObjects ?? [] {
            appDelegate.dataController.viewContext.delete(photo)
        }
        fetchImages()
    }
    
    //MARK: fetch request
    private func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "photoURL", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
}

