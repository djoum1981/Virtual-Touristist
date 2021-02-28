//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Julien Laurent on 2/25/21.
//

import UIKit

class LocationMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        FlickClient.getPhotos(lat: 0, long: 0) { (thePhotos, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            thePhotos.forEach { (pho) in
                print(pho.urlM)
            }
            
        }
    }

}

