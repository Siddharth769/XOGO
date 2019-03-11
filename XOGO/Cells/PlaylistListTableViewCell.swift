//
//  PlaylistListTableViewCell.swift
//  XOGO
//
//  Created by siddharth on 07/03/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit

class PlaylistListTableViewCell: UITableViewCell {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
