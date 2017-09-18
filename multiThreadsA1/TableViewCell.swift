//
//  TableViewCell.swift
//  multiThreadsA1
//
//  Created by Kartheek chintalapati on 9/14/17.
//  Copyright © 2017 Kartheek Chintalapati. All rights reserved.
//

/********************************************************************************************
 Has outlet to the label on the prototype cell.
 ********************************************************************************************/
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dataViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
