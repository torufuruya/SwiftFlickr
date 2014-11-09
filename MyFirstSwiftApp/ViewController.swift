//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Toru Furuya on 2014/11/09.
//  Copyright (c) 2014年 edu.myself. All rights reserved.
//

import UIKit

enum LayoutType: Int {
    case Grid = 0
    case List = 1
}

class ViewController: UICollectionViewController {
    
    var photos: [Dictionary<String, String>] = []
    var layoutType: LayoutType = LayoutType.Grid
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFlickrPhotos() {
        let manager: AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let url = "https://api.flickr.com/services/rest/"
        let parameters: Dictionary = [
            "method": "flickr.interestingness.getList",
            "api_key": "6058c681942912bb03adfcaee91b4af7",
            "per_page": "300",
            "format": "json",
            "nojsoncallback": "1",
            "extras": "url_q, url_z",
        ]
        let requestSuccess = { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            SVProgressHUD.dismiss()
            let response = responseObject as? Dictionary<String, AnyObject>
            let photos = response?["hoge"] as? NSArray
            self.collectionView?.reloadData()
            NSLog("requestSuccess \(responseObject)")
        }
        let requestFailure = { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            SVProgressHUD.dismiss()
            NSLog("requestFailure \(error)")
        }
        
        SVProgressHUD.show()
        manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.photos.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCell: PhotoCell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
        let photoInfo = self.photos[indexPath.item] as Dictionary<String, String>
        let photoUrlString = (self.layoutType == LayoutType.Grid) ? photoInfo["url_q"] : photoInfo["url_z"]
        let photoUrlRequest: NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(photoUrlString!))
        
        let imageRequestSuccess = {
            (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
            photoCell.photoImageView.image = image
            photoCell.photoImageView.alpha = 0
            UIView.animateWithDuration(0.2, animations: {
                photoCell.photoImageView.alpha = 1.0
            })
        }
        let imageRequestFailure = {
            (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            NSLog("imageRequestFailure")
        }
        
        photoCell.photoImageView.setImageWithURLRequest(photoUrlRequest, placeholderImage: nil, success: imageRequestSuccess, failure: imageRequestFailure)
        photoCell.photoInfo = photoInfo
        return photoCell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var itemSize: CGSize
        if self.layoutType == LayoutType.Grid {
            itemSize = (indexPath.item % 3 == 1) ? CGSizeMake(106, 106) : CGSizeMake(107, 106)
        } else {
            itemSize = CGSizeMake(320, 150)
        }
        return itemSize
    }
    
    @IBAction func secmentedControlDidChange(control: UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 0:
            self.layoutType = LayoutType.Grid
        case 1:
            self.layoutType = LayoutType.List
        default:
            self.layoutType = LayoutType.Grid
        }
        
        self.collectionView?.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowPhoto" {
//            let photoCell: PhotoCell = sender as PhotoCell
//            var photoViewController = segue.destinationViewController as PhotoViewController
//            photoViewController.photoInfo = photoCell.photoInfo
//        }
    }
}

