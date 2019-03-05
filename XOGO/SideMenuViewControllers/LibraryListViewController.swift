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
   
    var libraryStored: [LibraryCore] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToDos()
    }

    @IBAction func addLibraryButton(_ sender: Any) {
    }
    
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
    
}

extension LibraryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryStored.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath)
        cell.textLabel?.text = libraryStored[indexPath.row].mediaName
        return cell
    }
    
    
}


