//
//  MKTableViewCell.swift
//  Test
//
//  Created by giant on 17/4/20.
//  Copyright © 2017年 tableView. All rights reserved.
//

import UIKit

class MKTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLb.textColor = UIColor.black
        nameLb.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
