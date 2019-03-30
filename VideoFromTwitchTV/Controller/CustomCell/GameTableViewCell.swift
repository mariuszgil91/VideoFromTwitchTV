//
//  GameTableViewCell.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 30/03/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var gameViewers: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
