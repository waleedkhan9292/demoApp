//
//  WappController.swift
//  Wapp
//
//  Created by Macbook on 4/5/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import MapKit


class HomeMapController: UIViewController {
    
    var parrent:HomeController!
    var mediaType = ""
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Actions
    @IBAction func btnGoToiTunesMusiList(_ sender: UIButton) {
        parrent.mediaType = "itunes-music/hot-tracks"
        parrent.performSegue(withIdentifier: "HomeToMusicListSegue", sender: self)
    }
    
    @IBAction func btnGoToAppleMusiList(_ sender: UIButton) {
        parrent.mediaType = "apple-music/coming-soon"
        parrent.performSegue(withIdentifier: "HomeToMusicListSegue", sender: self)
    }
    
    // MARK: - Functions
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

