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
    
    //MARK: location functions
    @IBAction func addLocation(_ sender: Any) {
        print("Hello")
    }
    
    //MARK: handling long tap
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
    }
    
    //MARK: Annotation Adding to View
    func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        let newPin = createNewPin(coordinates: location)
        createdPins.append(newPin)
        mapView.addAnnotation(annotation)
    }
    
    //MARK: creating a new Pin
    func createNewPin(coordinates: CLLocationCoordinate2D) -> Pin{
        let newPin = Pin(context: appDelegate.dataController.viewContext)
        newPin.latitude = coordinates.latitude
        newPin.longitude = coordinates.longitude
        newPin.creationDate = Date()
        //try? AppDelegate.dataController.viewContext.save()
        return newPin
    }
}
