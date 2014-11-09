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

class ViewController: UIViewController {
    
    var photos = [String: String]()
    var layoutType: LayoutType = LayoutType.Grid

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFlickrPhotos() {
    }
}

