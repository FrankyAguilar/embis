//
//  MessageService.swift
//  Embis
//
//  Created by Franky Aguilar on 10/6/18.
//  Copyright © 2018 Ninth Industry. All rights reserved.
//

import MultiPeer

enum DataType: UInt32 {
    case string = 1
    case beaconRegion = 2
}


public class MessageService {
    
    public static let shared = MessageService()
  
    private init() {
       
        MultiPeer.instance.initialize(serviceType: "EMBIS")
        MultiPeer.instance.autoConnect()
        
    }
    

    
}
