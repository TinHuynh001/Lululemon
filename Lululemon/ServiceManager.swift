//
//  Services.swift
//  Lululemon
//
//  Created by TinHuynh on 8/30/19.
//  Copyright © 2019 TinHuynh. All rights reserved.
//

import Foundation

class ServiceManager : NSObject
{
    static let sharedInstance = ServiceManager()
    
    private override init() {}
    
    
    
    func shared() -> ServiceManager
    {
        return ServiceManager.sharedInstance
    }
    
}
