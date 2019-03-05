//
//  LibraryListTableViewCell.swift
//  XOGO
//
//  Created by siddharth on 05/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class LibraryListTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    
    @IBOutlet weak var mediaNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
