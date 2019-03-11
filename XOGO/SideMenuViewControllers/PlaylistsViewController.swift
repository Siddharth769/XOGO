//
//  PlaylistsViewController.swift
//  XOGO
//
//  Created by siddharth on 01/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class PlaylistsViewController: UIViewController {

    @IBOutlet weak var playListNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }

    @IBAction func addLibraryImageAssetButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showLibraryFromPlaylistSegue", sender: self )
    }
    
    @IBAction func saveButton(_ sender: Any) {

    }
  
}

