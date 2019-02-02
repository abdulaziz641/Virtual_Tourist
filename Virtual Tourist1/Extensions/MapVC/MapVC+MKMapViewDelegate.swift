//
//  MapVC+MKMapViewDelegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import MapKit

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
        
        performSegue(withIdentifier: StoryBoardId.LoadNewImagesSegue.rawValue, sender: view)
    }
}
