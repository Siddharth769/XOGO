//
//  PlaylistsListViewController.swift
//  XOGO
//
//  Created by siddharth on 04/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class PlaylistsListViewController: UIViewController {

    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let appdelegateObj: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var playlistStored: [Playlist] = []
    var playlistDetail: [PlaylistDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPlaylist()
        playlistLabel.text = "   Playlists(\(playlistStored.count))"
        tableView.reloadData()
    }
    
    
    @IBAction func addPlaylistsButton(_ sender: Any) {
    }
    
}

extension PlaylistsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistStored.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        cell.textLabel?.text = playlistStored[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(playlistStored[indexPath.row])
            playlistLabel.text = "   Playlists(\(playlistStored.count))"
            do {
                try context.save()
                playlistStored.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }catch {
                let saveError = error as NSError
                print("Error while saving, \(saveError)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPlaylistFromListSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPlaylistFromListSegue") {
            let dest = segue.destination as! PlaylistViewViewController
            let row = (sender as! NSIndexPath).row
            let rowPassed = playlistStored[row]
            dest.rowReceived = rowPassed
        }
    }
    
  
    
}

extension PlaylistsListViewController {
    
    func getPlaylist() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let playlist = try? context.fetch(Playlist.fetchRequest()) as? [Playlist] {
                if let playlistdata = playlist {
                    playlistStored = playlistdata
                }
            }
        }
    }
}

