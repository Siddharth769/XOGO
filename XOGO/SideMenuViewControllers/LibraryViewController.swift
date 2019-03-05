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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(LibraryViewController.imagepressed))
        selectMediaImageView.isUserInteractionEnabled = true
        selectMediaImageView.addGestureRecognizer(tapgesture)
        
    }

    @IBAction func saveButton(_ sender: Any) {

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
            try? context.save()
            navigationController?.popViewController(animated: true)
        }

        
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//
//            let lib = ToDoCore(entity: ToDoCore.entity(), insertInto: context)
//            if let taskText = taskName.text {
//                todo.name = taskText
//                todo.important = importanceSwitch.isOn
//            }
//            try? context.save()
//            navigationController?.popViewController(animated: true)
//        }
    }

}


extension LibraryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectMediaImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagepressed () {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}
