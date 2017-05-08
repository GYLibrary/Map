//
//  ViewController.swift
//  Test
//
//  Created by zhuguangyang on 2017/4/19.
//  Copyright © 2017年 tableView. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let height_screen:CGFloat = UIScreen.main.bounds.size.height
let width_screen:CGFloat = UIScreen.main.bounds.size.width
let SZListAnnotationName = "SZListAnnotationName"
class ViewController: UIViewController {

    var tableView: UITableView!
    
    var locationTableView: UITableView!
    
    var map:MKMapView?
    
    var geocoder: CLGeocoder?
    //多少组
    var dataArr:[SectionModel]? = []
    
    var chatModelArr:[ChatModel]? = []
    
    var currentIndex: Int = 0
    
    var currentCity: String = ""
    
    var locationManager:CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setDatas()
        setUI()
    }
    
    fileprivate  func setDatas() {
     
        for i in 0..<8 {
            
            let model = SectionModel()
            model.iconImage = ""
            model.userName = "用户\(i+1)"
            model.isBool = true
            
            dataArr?.append(model)
            
            let chatModel = ChatModel()
            
            chatModel.chatName = model.userName
            
            let index = arc4random()%4 + 1
            
            
            for j in 0..<index {
                
                chatModel.chatArr?.append("地点\(j+1)")

            }
            
            chatModelArr?.append(chatModel)
            
        }
        
    }
    
    fileprivate  func setUI() {
        
        tableView = UITableView(frame:  CGRect(x: 0, y: 0, width: width_screen, height: height_screen), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "GYTableViewCell", bundle: nil), forCellReuseIdentifier: "GYTableViewCellID")
        tableView.register(UINib.init(nibName: "SectionsCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionsCellID")
       
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        
//        if<#code#> <#condition#> {
//            
//        }
        locationManager?.distanceFilter = 10
        locationManager?.desiredAccuracy = 10
        locationManager?.startUpdatingLocation()
        
        locationTableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.register(UINib.init(nibName: "MKTableViewCell", bundle: nil), forCellReuseIdentifier: "MKTableViewCellID")
        tableView.reloadData()
        locationTableView.reloadData()
//        locationManager?.startUpdatingLocation()
        
        geocoder = CLGeocoder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == locationTableView {
            return 1
        }
        
        return dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == locationTableView {
            
            let model2 = (chatModelArr?[currentIndex])! as ChatModel
            return model2.chatArr?.count ?? 0
            
        }
        
        let chatmodel = (dataArr?[section])! as SectionModel
        
        if chatmodel.isBool! {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == locationTableView {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "MKTableViewCellID") as! MKTableViewCell
            let model2 = (chatModelArr?[currentIndex])! as ChatModel
            cell1.nameLb.text = model2.chatArr?[indexPath.row]
            
            
            return cell1
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GYTableViewCellID") as! GYTableViewCell
        map = cell.map
        locationManager?.startUpdatingLocation()
        cell.hideView.isHidden = true
        cell.mapView.transform =  CGAffineTransform(translationX: -width_screen + 110, y: 0)
        
        cell.map.delegate = self
        cell.map.becomeFirstResponder()
        cell.selectionStyle = .none
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            cell.mapView.transform = CGAffineTransform.identity
            
        }, completion: { (_) in
            
            let model = (self.chatModelArr?[indexPath.section])! as ChatModel
            model.expendBool = true
            
            tableView.beginUpdates()
            cell.hideView.isHidden = false
//            tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.top, animated: true)
             tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
            tableView.endUpdates()
        })
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == locationTableView{
            return
        }
        
         let model = (self.chatModelArr?[indexPath.section])! as ChatModel
         model.expendTwoBool = true
        tableView.beginUpdates()
//        tableView.scrollToNearestSelectedRow(at: UITableViewScrollPosition.top, animated: true)
        tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == locationTableView {
            return 27
        }
        
        let model = (chatModelArr?[indexPath.section])! as ChatModel
        
        if model.expendTwoBool {
            return height_screen * 0.8
        }
        
        if model.expendBool {
            
            return 200
            
        }
       
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == locationTableView{
            
            let view = UIView(frame: CGRect(x: 10, y: 0, width: 200, height: 30))
            let lb = UILabel()
            lb.frame = view.frame
            lb.text = currentCity
            lb.sizeToFit()
            view.addSubview(lb)
            
            return view
        }
        
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionsCellID") as! SectionsCell
        
        cell.tag = 666 + section
        
        let model = (dataArr?[section])! as SectionModel
        
        
        cell.userNameLb.text = model.userName
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFold(_:)))
        
        cell.addGestureRecognizer(tap)
        
        
        return cell
    }
    
    func tapFold(_ tap: UITapGestureRecognizer)  {
                
        let index = (tap.view?.tag)! - 666
        
        if currentIndex != index {
            let model = (dataArr?[currentIndex])! as SectionModel
            if !model.isBool! {
                model.isBool = !model.isBool!
            }
            let model2 = (chatModelArr?[index])! as ChatModel
            model2.expendBool = false
            model2.expendTwoBool = false
        }
        
        let model = (dataArr?[index])! as SectionModel
        
        currentIndex = index
        
        model.isBool = !model.isBool!
        
        let model2 = (chatModelArr?[index])! as ChatModel
        model2.expendBool = false
        model2.expendTwoBool = false
        
        tableView.reloadData()
        locationTableView.reloadData()
        
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == locationTableView{
            return 30
        }
       
        
        return 90
    }
    
    
}

extension ViewController : MKMapViewDelegate,CLLocationManagerDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
//        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: SZListAnnotationName)
        annotationView?.canShowCallout = false
        if annotationView == nil {
            annotationView = SZListAnnotationView(annotation: annotation, reuseIdentifier: SZListAnnotationName)
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
        
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
////        if annotation.title! == "Current Location" {
////            
////            return nil
////        }
//        
//        if annotation.isKind(of: MKUserLocation.self) {
//            
//            let pin = MKAnnotationView()
//            pin.image = UIImage(named: "chang")
//            pin.canShowCallout = false
//            return pin
//            
//        }
//        
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationID")
//        
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationID")
//            annotationView?.frame = CGRect(x: 0, y: 0, width: 150, height: 180)
////            let view = UIView(frame: (annotationView?.frame)!)
//            
//            locationTableView.frame = (annotationView?.frame)!
////            locationTableView.frame = view.frame
////            view.addSubview(locationTableView)
////            locationTableView.isScrollEnabled = true
////            annotationView?.isEnabled = false
////            annotationView?.addSubview(locationTableView)
//            annotationView?.insertSubview(locationTableView, at: 0)
//        }
////        annotationView?.centerOffset = CGPoint(x: -60, y: -80)
//        
//        //大头针
////        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationID")
////        
////        if annotationView == nil {
////            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationID")
////            annotationView?.frame = CGRect(x: 9, y: 10, width: 120, height: 80)
////            locationTableView.frame = (annotationView?.frame)!
////            annotationView?.addSubview(locationTableView)
//        
//
////            return annotationView
////        }
//        locationTableView.reloadData()
//        
//        return annotationView
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currenLocation = locations.last
        let span = MKCoordinateSpanMake(0.03, 0.03)
        if map != nil {

            map?.setRegion(MKCoordinateRegionMake((currenLocation?.coordinate)!, span), animated: true)
            
        }
        
        if currenLocation != nil {
        
        geocoder?.reverseGeocodeLocation(currenLocation!, completionHandler: { (placemarks, error) in
            
            let placemark = placemarks?[0]
            
            self.currentCity = placemark?.administrativeArea ?? "暂无"
        })
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
  
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        if status.rawValue == 0 || status.rawValue == 3 {
            // isLocationSuccess = true
            
            manager.startUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        
    }
    
}


class SectionModel: NSObject {

    var iconImage:String?
    var userName:String?
    var isBool: Bool?
    
}

class ChatModel: NSObject {
    var chatName:String?
    var expendBool:Bool = false
    var expendTwoBool: Bool = false
    var chatArr:[String]? = []
    
//    var chatSendId:String?
}

