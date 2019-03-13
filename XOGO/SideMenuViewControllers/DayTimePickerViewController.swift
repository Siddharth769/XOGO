//
//  DayTimePickerViewController.swift
//  XOGO
//
//  Created by siddharth on 12/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class DayTimePickerViewController: UIViewController{
    
    @IBOutlet weak var timepicker: UIPickerView!
    
    var uuidPassed: String?
    var playlistName: String?
    var assetName: String?
    var timer: String?
    var timeArray = ["15","30","45","60"]
    var dayss: String = ""
    var playlist: [PlaylistDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func saveButton(_ sender: Any) {
        savePlaylistItem()
        self.navigationController?.popViewController(animated: true)
    }
    
}



// Picker Functions extension ------------------------------------------------------------------------------------

extension DayTimePickerViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        timer = timeArray[row]
        print(timer!)
        return timeArray[row]
    }
}


//Core Data functionality ----------------------------------------------------------------------------------------

extension DayTimePickerViewController {
    
    func savePlaylistItem(){
   
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let assets = PlaylistDetail(entity: PlaylistDetail.entity(), insertInto: context)
            assets.days = ""
            if let uuidP = uuidPassed {
                assets.id = uuidP
            }
            if let imageP = assetName {
                assets.image = imageP
            }
            if let timeP = timer {
                 assets.time = timeP
            }
            
            try? context.save()
           }
        }
 
}
