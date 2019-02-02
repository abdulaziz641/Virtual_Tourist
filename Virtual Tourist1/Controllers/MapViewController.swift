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
    @IBOutlet weak var editImagesButton: UIBarButtonItem!
    var fetchedImages: [URL] = []
    var createdPins: [Pin]!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fetchedResultsController: NSFetchedResultsController<Pin>!
    
    //MARK: Implementing Required functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupFetchedResultsController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchedResultsController = nil
    }
    
    //MARK: IBActions
    @IBAction func editPins(_ sender: Any) {
        self.performSegue(withIdentifier: StoryBoardId.LoadNewImagesSegue.rawValue, sender: view)
    }
    
    //MARK: fetch request
    fileprivate func setupFetchedResultsController() {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.dataController.viewContext, sectionNameKeyPath: nil, cacheName: "pins")
        fetchedResultsController.delegate = self
        do {
            if let result = try? appDelegate.dataController.viewContext.fetch(fetchRequest) {
                createdPins = result
            }
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    //MARK: UI Configurations
    func addPinsToMap() {
        var loadedPins: [MKPointAnnotation] = []
        for pin in createdPins {
            let pinLocation = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            let pinToAdd = MKPointAnnotation()
            pinToAdd.coordinate = pinLocation
            loadedPins.append(pinToAdd)
        }
        mapView.addAnnotations(loadedPins)
    }
    
    func setDefaultRegion(around location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.region = region
    }
    
    //MARK: View Initialization
    func initializeApp() {
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap))
        longTapGesture.minimumPressDuration = 0.9
        mapView.delegate = self
        mapView.addGestureRecognizer(longTapGesture)
        createdPins = []
        setupFetchedResultsController()
        addPinsToMap()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardId.LoadNewImagesSegue.rawValue {
            let photosVC = storyboard?.instantiateViewController(withIdentifier: StoryBoardId.PhotosCollectionVC.rawValue) as! CollectionViewController
            if let sender = sender as? MKAnnotationView {
                photosVC.receivedPinFromSegue = sender.annotation?.coordinate
                photosVC.pinsCreated = createdPins
            }
        }
    }
}
