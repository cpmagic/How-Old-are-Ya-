//
//  Time.swift
//  How Old Are Ya'
//
//  Created by Thomas Hill on 10/20/18.
//  Copyright © 2018 Computer Magic. All rights reserved.
//

import Foundation

struct Time {
    
    var seconds: Double = 0.0

    var minutes: Double {
        
        get {
            return seconds / 60.0
        }
        set {
            self.seconds = newValue * 60.0
        }
    }
    
    init(seconds: Double) {
        self.seconds = seconds
    }
    
}
