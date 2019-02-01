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
    
    //MARK: class properties and Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    var fetchedImages: [URL] = []
    var createdPins: [Pin]!
    
    //    var dataController: DataController!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedResultsController: NSFetchedResultsController<Pin>!
    
    //MARK: fetch request
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: appDelegate.dataController.viewContext,
                                                              sectionNameKeyPath: nil, cacheName: "pins")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
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
        //fetchedResultsController = nil
    }
    
    @IBAction func editPins(_ sender: Any) {
        self.performSegue(withIdentifier: "loadRelatedImages", sender: view)
    }
    
    //MARK: UI Configurations
    func addPinsToMap() {
        let lat = CLLocationDegrees(24.79)
        let long = CLLocationDegrees(46.62)
        
        let studnetLocationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let newPinAnnotation = MKPointAnnotation()
        newPinAnnotation.coordinate = studnetLocationCoordinates
        
        mapView.addAnnotation(newPinAnnotation)
        let region = MKCoordinateRegion(center: studnetLocationCoordinates,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.region = region
    }
    
    func setDefaultRegion() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20, longitude: 45),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.region = region
    }
    
    //View Initialization
    func initializeApp() {
        mapView.delegate = self
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap))
        longTapGesture.minimumPressDuration = 0.9
        mapView.addGestureRecognizer(longTapGesture)
        createdPins = []
        //setupFetchedResultsController()
        addPinsToMap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loadRelatedImages" {
            let photosVC = storyboard?.instantiateViewController(withIdentifier: "photosVC") as! CollectionViewController
            if let sender = sender as? MKAnnotationView {
                photosVC.receivedPinFromSegue = sender.annotation?.coordinate
                photosVC.pinsCreated = createdPins
            }
        }
    }
}

