//
//  AppDelegate.swift
//  butterfly blink
//
//  Created by Florian Gutmann on 20.03.19.
//  Copyright © 2019 Florian Gutmann. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let blinker = Blinker()
   
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        blinker.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        blinker.stop()
    }
}

