//
//  MapVC+NSFetchedResultsControllerDelegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import Foundation
import CoreData
import MapKit

extension MapViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        guard let pin = anObject as? Pin else {
            showAlert(title: "Error", message: "Unable to case anObject to Pin", buttonText: "OK")
            return
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = pin.latitude
        annotation.coordinate.longitude = pin.longitude
        
        switch type {
        case .insert:
            mapView.addAnnotation(annotation)
            break
        case .delete:
            mapView.removeAnnotation(annotation)
            break
        case .update: break
        case .move: break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            break
//            tableView.insertSections(indexSet, with: .fade)
        case .delete: break
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
    }
}
