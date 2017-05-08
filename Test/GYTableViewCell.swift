
//
//  GYTableViewCell.swift
//  Test
//
//  Created by ZGY on 2017/4/20.
//  Copyright © 2017年 tableView. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/4/20  10:21
//  GiantForJade:  Efforts to do my best
//  Real developers ship.


import UIKit
import MapKit

class GYTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hideView.isHidden = true
        textField.tintColor = UIColor.red
        iconImage.layer.cornerRadius = iconImage.frame.width / 2
        iconImage.layer.masksToBounds = true
        map.showsUserLocation = true
        map.autoresizingMask = UIViewAutoresizing.flexibleHeight
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.sizeToFit()
//        let span = MKCoordinateSpanMake(0.03, 0.03)
//
//        let coordinate = CLLocationCoordinate2DMake(22.5807788292, 113.9620091523)
//        let region = MKCoordinateRegionMake(coordinate, span)
//        map.setRegion(region, animated: true)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
