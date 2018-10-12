//
//  ViewController.swift
//  Embis
//
//  Created by Franky Aguilar on 10/5/18.
//  Copyright © 2018 Ninth Industry. All rights reserved.
//

import UIKit
import Foundation
import MultiPeer

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        MultiPeer.instance.initialize(serviceType: "EMBIS")
        MultiPeer.instance.autoConnect()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func iba_pushListenVC(){
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListenViewController") as! ListenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @IBAction func iba_pushBroadcastVC(){
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BroadcastViewController") as! BroadcastViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
}

