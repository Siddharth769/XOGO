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
    
    let uuid = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(uuid)
    }

    @IBAction func addLibraryImageAssetButton(_ sender: Any) {
        if playListNameField.text == ""{
            showAlert(for: "Please enter playlist name first")
        }else {
            self.performSegue(withIdentifier: "showLibraryFromPlaylistSegue", sender: self )

        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLibraryFromPlaylistSegue") {
            let dest = segue.destination as! LibraryListViewController
            dest.passedPlaylistName = playListNameField.text
            dest.uuidReceived = uuid
        }
    }
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

