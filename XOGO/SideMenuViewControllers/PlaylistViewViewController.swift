//
//  PlaylistViewViewController.swift
//  XOGO
//
//  Created by siddharth on 13/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class PlaylistViewViewController: UIViewController {

    var rowReceived: Playlist?
    var playlistDetailForParticulatPlaylist: [PlaylistDetail] = []
    var playlistAssetsInTotal: [PlaylistDetail] = []
    var url: URL?
    
    let appdelegateObj: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(rowReceived)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPlaylistAssets()
    
    }

    func getPlaylistAssets() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let request: NSFetchRequest<PlaylistDetail> = PlaylistDetail.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", rowReceived!.id!)
            request.returnsObjectsAsFaults = false
            do  {
                playlistDetailForParticulatPlaylist = try context.fetch(request)
                print(playlistDetailForParticulatPlaylist)
            } catch {
                print("There was an error fetching CST Project Details.")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    
}

extension PlaylistViewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistDetailForParticulatPlaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistItemCell", for: indexPath) as! PlaylistViewTableViewCell
        
        let data = playlistDetailForParticulatPlaylist[indexPath.row]
        cell.nameField.text = data.image
        cell.daysField.text = data.days
        cell.timerField.text = data.time! + " secs"
        
        url = self.getDocumentsDirectory()
        if let imagePath = data.image,
            let image = UIImage(contentsOfFile: (url?.appendingPathComponent(imagePath).path)!) {
            cell.assetImageView?.image = image
        }else {
            cell.assetImageView?.image = UIImage(named: "warning")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context?.delete(playlistDetailForParticulatPlaylist[indexPath.row])
            do {
                try context?.save()
                playlistDetailForParticulatPlaylist.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }catch {
                let saveError = error as NSError
                print("Error while saving, \(saveError)")
            }
        }
    }
    
    
}
