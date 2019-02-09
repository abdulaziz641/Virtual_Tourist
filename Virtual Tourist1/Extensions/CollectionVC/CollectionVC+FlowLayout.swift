//
//  CollectionVC+FlowLayout.swift
//  Virtual Tourist1
//
//  Created by Abdulaziz Alsaloum on 01/02/2019.
//  Copyright © 2019 Abdulaziz Alsaloum. All rights reserved.
//

import UIKit

extension PhotoAlbumViewController: UICollectionViewDelegateFlowLayout {
    
    //Mark: UICollectionViewDelegateFlowLayout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //Mark: UI configuration
    func configureFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.width - 2) / 3
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = dimension
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func editingConfiguration() {
        if isEditingImages {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(editImages(_:)))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Images", style: .plain, target: self, action: #selector(editImages(_:)))
        }
    }
}
