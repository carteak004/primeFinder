//
//  TableViewCell.swift
//  multiThreadsA1
//
//  Created by ta on 9/6/17.
//  Copyright © 2017 ta. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var dispLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
