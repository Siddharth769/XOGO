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
    @IBOutlet weak var assetsNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var imagesNamesArray: [String] = []
    
    var assetArrayItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Received")
        print(imagesNamesArray)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func addLibraryImageAssetButton(_ sender: Any) {
        performSegue(withIdentifier: "addImageFromLibrary", sender: self)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
   
}

extension PlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistAssets", for: indexPath)
        cell.textLabel?.text = imagesNamesArray[indexPath.row]
        return cell
    }
    
    
}
