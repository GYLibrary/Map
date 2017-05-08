//
//  SZListDetailView.swift
//  SZMap
//
//  Created by 吴三忠 on 2017/4/5.
//  Copyright © 2017年 吴三忠. All rights reserved.
//

import UIKit

class SZListDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    class func listDetailView() -> SZListDetailView{
        return Bundle.main.loadNibNamed("SZListDetailView", owner: self, options: nil)?.first as! SZListDetailView
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UINib(nibName: "SZListDetailCell", bundle: nil), forCellReuseIdentifier: "listDetailCell")
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundBtn.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }
    
    // MARK: - UITableViewDelegate/DataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listDetailCell", for: indexPath) as! SZListDetailCell
        return cell;
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
