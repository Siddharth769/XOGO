//
//  LibraryListViewController.swift
//  XOGO
//
//  Created by siddharth on 04/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class LibraryListViewController: UIViewController {

    let appdelegateObj: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var libraryStored: [LibraryCore] = []
    var playlistStored: [Playlist] = []    
    var url: URL?
    var assetItem: String?
    var passedPlaylistName: String?
    var uuidReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(LibraryListViewController.longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPress)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLibrary()
        libraryLabel.text = "   Library(\(libraryStored.count))"
        
    }

}

// Actions ----------------------------------------------------------------------------------------------------

extension LibraryListViewController {
    
    @IBAction func addLibraryButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.performSegue(withIdentifier: "addTimeDaysToPlaylistSegue", sender: self)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        savePlaylist()
        pushToPlaylistView()
    }
    
    func pushToPlaylistView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlaylistsListViewController") as! PlaylistsListViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addTimeDaysToPlaylistSegue"){
            let dest = segue.destination as! DayTimePickerViewController
            dest.uuidPassed = uuidReceived
            dest.assetName = assetItem
            dest.playlistName = passedPlaylistName
        }
    }
}

// Table view functionality ----------------------------------------------------------------------------------------

extension LibraryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryStored.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! LibraryListTableViewCell
        let data = libraryStored[indexPath.row]
        cell.mediaNameLabel.text = data.mediaName

        url = self.getDocumentsDirectory()
        if let imagePath = data.photo,
            let image = UIImage(contentsOfFile: (url?.appendingPathComponent(imagePath).path)!) {
                    cell.mediaImageView?.image = image
        }else {
            cell.mediaImageView.image = UIImage(named: "warning")
        }
         return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(libraryStored[indexPath.row])
            libraryLabel.text = "   Library(\(libraryStored.count))"
            do {
                try context.save()
                libraryStored.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }catch {
                let saveError = error as NSError
                print("Error while saving, \(saveError)")
            }
        }
    }
    
}

// Coredata functions extension ------------------------------------------------------------------------------------

extension LibraryListViewController {
    
    func getLibrary() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let libraryData = try? context.fetch(LibraryCore.fetchRequest()) as? [LibraryCore] {
                if let librarydata = libraryData {
                    libraryStored = librarydata
                    tableView.reloadData()
                }
            }
        }
    }
    

    
    // Adding long press functionality to table view to select images to add to playlist
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer){
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print("cell at \(indexPath)")
                let asset = libraryStored[indexPath.row]
                print(asset.photo!)
                assetItem = asset.photo
                saveButtonOutlet.alpha = 1.0
                doneButtonOutlet.alpha = 1.0
                saveButtonOutlet.isUserInteractionEnabled = true
                doneButtonOutlet.isUserInteractionEnabled = true
            }
        }
    }
    
    
    func savePlaylist(){
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let playlist = Playlist(entity: Playlist.entity(), insertInto: context)
            
            if let id = uuidReceived {
                playlist.id = id
            }
            if let name = passedPlaylistName {
                playlist.name = name
            }
            try? context.save()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

