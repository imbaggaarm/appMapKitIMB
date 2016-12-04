//
//  ViewController.swift
//  appMapKit
//
//  Created by Dung Duong on 12/4/16.
//  Copyright © 2016 Tai Duong. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var onOff: Bool = false
    
    let map: MKMapView = {
        let temp = MKMapView()
        return temp
    }()
    let but: UIButton = {
        let temp = UIButton(type: .system)
        temp.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        temp.setTitle("Press to set region", for: .normal)
        temp.setTitleColor(.white, for: .normal)
        temp.backgroundColor = UIColor.blue
        temp.layer.cornerRadius = 10
        temp.clipsToBounds = true
        
        return temp
    }()
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if onOff
        {
            let location = locations[0]
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            map.setRegion(region, animated: true)
            self.map.showsUserLocation = true
            print(location.altitude)
            print(location.speed)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        view.addSubview(map)
        view.addSubview(but)
        but.addTarget(self, action: #selector(setRegion), for: .touchUpInside)
        map.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    func setRegion()
    {
        if !onOff
        {
            manager.delegate = self
            onOff = true
        }
        else
        {
            onOff = false
        }
    }

}

