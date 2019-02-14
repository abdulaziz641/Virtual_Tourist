//
//  MapViewController.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
    
    //MARK: class properties and Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    var isEditingPins = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedResultsController: NSFetchedResultsController<Pin>!
    
    //MARK: Implementing Required functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: IBActions
    @objc func editPins(_ sender: Any) {
        isEditingPins = !isEditingPins
        editingConfiguration()
    }
        
    //MARK: fetch request
    func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let viewContext = appDelegate.dataController.viewContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: "pins")
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            showAlert(title: "Fetching Failure", message: "The fetch could not be performed.", buttonText: "Ok")
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardId.LoadNewImagesSegue.rawValue {
            let photosVC = segue.destination as! PhotoAlbumViewController
            if let sender = sender as? MKAnnotationView {
                let lat = Double((sender.annotation?.coordinate.latitude)!)
                let long = Double((sender.annotation?.coordinate.longitude)!)
                //photosVC.loadedPinFromStore = Pin(context: appDelegate.dataController.viewContext)
                photosVC.loadedPinFromStore = loadPin(lat: lat, long: long)!
                photosVC.receivedPinFromSegue = sender.annotation?.coordinate
            }
        }
    }
}
