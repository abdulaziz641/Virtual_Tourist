//
//  MapVC+UIConfigurations.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 03/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit

extension MapViewController {
    
    //MARK: UI Configurations
    func addPinsToMap() {
        var loadedPins: [MKPointAnnotation] = []
        for pin in fetchedResultsController?.fetchedObjects ?? [] {
            let pinLocation = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            let pinToAdd = MKPointAnnotation()
            pinToAdd.coordinate = pinLocation
            loadedPins.append(pinToAdd)
        }
        mapView.addAnnotations(loadedPins)
    }
    
    func editingConfiguration() {
        if isEditingPins {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editPins(_:)))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editPins(_:)))
        }
    }
    
    func configureGesureRecognizer() {
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap))
        longTapGesture.minimumPressDuration = 0.9
        mapView.addGestureRecognizer(longTapGesture)
    }
    
    //MARK: View Initialization
    func initializeApp() {
        mapView.delegate = self
        configureGesureRecognizer()
        editingConfiguration()
        setupFetchedResultsController()
        addPinsToMap()
    }
}
