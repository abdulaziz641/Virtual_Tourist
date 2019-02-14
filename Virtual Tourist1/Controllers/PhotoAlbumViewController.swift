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
        if fetchedResultsController.fetchedObjects?.count == 0 {
            fetchImages()
        } else {
            loadNewImagesButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editingConfiguration()
        configureFlowLayout()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        try! self.appDelegate.dataController.viewContext.save()
    }
    
    //MARK: IBActions
    @objc func editImages(_ sender: Any) {
        isEditingImages = !isEditingImages
        editingConfiguration()
    }
    
    @IBAction func fetchNewImages(_ sender: Any) {
        loadNewImagesButton.isEnabled = false
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
        
        let predicate = NSPredicate(format: "pin == %@", loadedPinFromStore)
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            showAlert(title: "Failure", message: "The fetch could not be performed", buttonText: "OK")
        }
    }
}
