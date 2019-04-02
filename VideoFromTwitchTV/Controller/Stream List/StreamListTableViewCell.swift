//
//  StreamListTableViewCell.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 01/04/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit

class StreamListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var streamThumbnail: UIImageView!
    
    @IBOutlet weak var streamerNameLabel: UILabel!
    
    @IBOutlet weak var streamViewersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
