//
//  PlaylistViewTableViewCell.swift
//  XOGO
//
//  Created by siddharth on 13/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class PlaylistViewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var daysField: UILabel!
    @IBOutlet weak var timerField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
