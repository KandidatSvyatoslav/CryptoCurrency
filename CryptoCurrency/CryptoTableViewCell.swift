//
//  CryptoTableViewCell.swift
//  CryptoCurrency
//
//  Created by Admin on 28.07.17.
//  Copyright © 2017 Svt. All rights reserved.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var costLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
