//
//  PhotoCell.swift
//  MyFirstSwiftApp
//
//  Created by Toru Furuya on 2014/11/09.
//  Copyright (c) 2014年 edu.myself. All rights reserved.
//

import Foundation

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    var photoInfo: Dictionary<String, String>?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
}
