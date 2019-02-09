//
//  MapVc+PinAndAnnotation.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension MapViewController {
    
    //MARK: handling long tap
    @objc func longTap(sender: UIGestureRecognizer){
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            createNewPin(coordinates: locationOnMap)
        }
    }
    
    //MARK: creating a new Pin
    func createNewPin(coordinates: CLLocationCoordinate2D) {
        let newPin = Pin(context: appDelegate.dataController.viewContext)
        newPin.latitude = coordinates.latitude
        newPin.longitude = coordinates.longitude
        newPin.creationDate = Date()
        try? appDelegate.dataController.viewContext.save()
    }
    
    //MARK: remove a Pin from store
    func removePin(lat: Double, long: Double) {
        let pinToDelete = loadPin(lat: lat, long: long)!
        appDelegate.dataController.viewContext.delete(pinToDelete)
        try! appDelegate.dataController.viewContext.save()
    }
    
    //MARK: load pin from store
    func loadPin(lat: Double, long: Double) -> Pin? {
        return fetchedResultsController.fetchedObjects?.first(where: { $0.latitude == lat && $0.longitude == long})
    }
}
