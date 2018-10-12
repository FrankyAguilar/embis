//
//  BroadcastViewController.swift
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

class BroadcastViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!

    var selectedEmoji = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLocalBeacon()
    }
    
    func initLocalBeacon() {
        if localBeacon != nil {
            stopLocalBeacon()
        }
        
        let udid = UIDevice.current.identifierForVendor?.uuidString
        print(udid as Any)
        
        let localBeaconUUID = udid
        let localBeaconMajor: CLBeaconMajorValue = 123
        let localBeaconMinor: CLBeaconMinorValue = 456
        
        let uuid = UUID(uuidString: localBeaconUUID!)!
        localBeacon = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier: "EMBIS")
        
        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        
        MultiPeer.instance.send(object: localBeacon, type: DataType.beaconRegion.rawValue)

        
    }
    
    func stopLocalBeacon() {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print(beaconPeripheralData)
            peripheralManager.startAdvertising(beaconPeripheralData as! [String: AnyObject]!)
        } else if peripheral.state == .poweredOff {
            peripheralManager.stopAdvertising()
        }
    }
    
    @IBAction func iba_choseEmoji(sender: UIButton){
        self.selectedEmoji = (sender.titleLabel?.text)!
        MultiPeer.instance.send(object: self.selectedEmoji, type: DataType.string.rawValue)


    }
    
}
