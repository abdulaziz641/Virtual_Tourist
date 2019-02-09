//
//  CollectionVC+NSFetchedResultsDelegate.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import CoreData

extension PhotoAlbumViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) { collectionView.reloadData() }
}
