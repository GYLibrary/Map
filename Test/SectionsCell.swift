//
//  SectionsCell.swift
//  Test
//
//  Created by ZGY on 2017/4/19.
//  Copyright © 2017年 tableView. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/19  19:05
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit

class SectionsCell: UITableViewHeaderFooterView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = imageView.layer.frame.width / 2
        imageView.layer.masksToBounds = true
    }

    
    
}
