//
//  LibraryModel.swift
//  XOGO
//
//  Created by siddharth on 04/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import Foundation
import UIKit

class Library {
    var photo: UIImage!
    var mediaName: String!
    var tags: String?
    var notes: String?
    
    init(photo: UIImage, mediaName: String, tags: String, notes: String){
        self.photo = photo
        self.mediaName = mediaName
        self.tags = tags
        self.notes = notes
    }
    
}
