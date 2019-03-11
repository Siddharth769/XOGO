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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var savePlalistAsset: UIButton!
    @IBOutlet weak var donePlaylist: UIButton!
    @IBOutlet weak var libraryLabel: UILabel!
    
    let appdelegateObj: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var libraryStored: [LibraryCore] = []
    var url: URL?
    var assetName: String?
    var assetArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(LibraryListViewController.longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPress)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToDos()
        libraryLabel.text = "   Library(\(libraryStored.count))"
    }

    @IBAction func addLibraryButton(_ sender: Any) {
    }
    
    
}

// Table view functionality ----------------------------------------------------

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

// Coredata functions extension ----------------------------------------------------

extension LibraryListViewController {
    
    func getToDos() {
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
                savePlalistAsset.alpha = 1.0
                savePlalistAsset.isUserInteractionEnabled = true
                donePlaylist.alpha = 1.0
                donePlaylist.isUserInteractionEnabled = true
                let asset = libraryStored[indexPath.row]
                print(asset.photo!)
                assetName = asset.photo
            }
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

