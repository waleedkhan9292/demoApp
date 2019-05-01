//
//  ItunesListCell.swift
//  DemoApp
//
//  Created by Macbook Pro on 30/04/2019.
//  Copyright © 2019 Waleed Waheed Khan. All rights reserved.
//

import UIKit

class ItunesListCell: UITableViewCell {
    
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblMediaType: UILabel!
    
    @IBOutlet weak var ivDisplayImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
