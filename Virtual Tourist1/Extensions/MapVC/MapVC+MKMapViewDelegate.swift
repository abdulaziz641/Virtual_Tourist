//
//  MapVC+MKMapViewDelegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import MapKit
import CoreData
extension MapViewController: MKMapViewDelegate {
    //MARK: Delegate Functions
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = StoryBoardId.PinResueIdentifier.rawValue
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.isEnabled = true
            pinView?.canShowCallout = true
            pinView?.tintColor = .red
        }else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if !isEditingPins {
            performSegue(withIdentifier: StoryBoardId.LoadNewImagesSegue.rawValue, sender: view)
        } else {
            let lat = view.annotation?.coordinate.latitude
            let long = view.annotation?.coordinate.longitude
            
            if let loadedPin = loadPin(lat: lat!, long: long!) {
                appDelegate.dataController.viewContext.delete(loadedPin)
                try! appDelegate.dataController.viewContext.save()
            }
        }
    }
}
