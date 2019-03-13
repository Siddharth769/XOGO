//
//  LibraryViewController.swift
//  XOGO
//
//  Created by siddharth on 01/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import CoreData

class LibraryViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var tagField: UITextView!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var selectMediaImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var newPath: URL?
    var str = Int.random(in: 0..<1000)
    var filename: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(LibraryViewController.imagepressed))
        selectMediaImageView.isUserInteractionEnabled = true
        selectMediaImageView.addGestureRecognizer(tapgesture)
        
    }

    @IBAction func saveButton(_ sender: Any) {
            saveLibrary()
            navigationController?.popViewController(animated: true)
        }

    

}

//ImagePicker Extension -------------------------------------------------------------------------------------------

extension LibraryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Used relative path to get doc directory as sandboxing changes paths on each simultaion.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectMediaImageView.image = selectedImage
        filename = "image\(str).jpg"
        print(filename!)
        let fileURL = self.getDocumentsDirectory().appendingPathComponent(filename!)
        print(fileURL)
        let imageData = selectedImage.jpegData(compressionQuality: 1.0)
        do {
            try imageData?.write(to: fileURL, options: .atomic)
        }catch{
            print("Unable to save image at document diretory")
        }
        
        dismiss(animated: true, completion: nil)
    }

    
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @objc func imagepressed () {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}


//Coredata functions extension ---------------------------------------------------------------------------------

extension LibraryViewController {
    
    func saveLibrary(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let lib = LibraryCore(entity: LibraryCore.entity(), insertInto: context)
            if let nameText = nameField.text {
                lib.mediaName = nameText
            }
            if let tagText = tagField.text {
                lib.tags = tagText
            }
            if let noteText = notesField.text {
                lib.notes = noteText
            }
            if let imagepath = filename {
                lib.photo = imagepath
                print(imagepath)
            }
            try? context.save()
        }
    }
}
