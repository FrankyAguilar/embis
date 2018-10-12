//
//  ListenViewController.swift
//  Embis
//
//  Created by Franky Aguilar on 10/6/18.
//  Copyright © 2018 Ninth Industry. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import CoreLocation
import MultiPeer
class ListenViewController:UIViewController, CLLocationManagerDelegate, MultiPeerDelegate {
    
    var beaconManager: BeaconManager!
    var locationManager:CLLocationManager!
    
    @IBOutlet weak var ibo_beaconName:UILabel?
    @IBOutlet weak var ibo_beaconMajor:UILabel?
    @IBOutlet weak var ibo_beaconMinor:UILabel?
    @IBOutlet weak var ibo_beaconProx:UILabel?
    
    @IBOutlet weak var ibo_selectedThang:UILabel?

    
    var beaconRegion: CLBeaconRegion!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MultiPeer.instance.delegate = self
    }
    
    //GET INITIAL SEND PACKAGE
    func multiPeer(didReceiveData data: Data, ofType type: UInt32) {
        switch type {
        case DataType.string.rawValue:
            let string = data.convert() as! String
            self.ibo_selectedThang?.text = string
            break
            
            
        case DataType.beaconRegion.rawValue:
            let beacon = data.convert() as! CLBeaconRegion
            self.beaconRegion = beacon
            initLocalBeacon()
            break
            
        default:
            break
        }
    }
    
    func multiPeer(connectedDevicesChanged devices: [String]) {
        print(devices)
    }
    
    func initLocalBeacon() {
 
        print("Init Beacon")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        if beacons.count > 0 {
            
            self.ibo_beaconName!.text = "UDID: \(beacons[0].proximityUUID.uuidString)"
            self.ibo_beaconMajor?.text = "Major: \(beacons[0].major.stringValue)"
            self.ibo_beaconMinor!.text = "Major: \(beacons[0].minor.stringValue)"
            self.ibo_beaconProx!.text = "PROX: \(String(beacons[0].proximity.rawValue))"

            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            case .far:
                self.view.backgroundColor = UIColor.red
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                
            case .immediate:
                self.view.backgroundColor = UIColor.green
            }
        }
    }
    
    
    
    
    
}
