//
//  Blinker.swift
//  butterfly blink
//
//  Created by Florian Gutmann on 20.03.19.
//  Copyright © 2019 Florian Gutmann. All rights reserved.
//

import Foundation

/**
 Class that periodically blinks the screen at a fixed interval rate.
 */
class Blinker {
    
    /** Pointer used for the display fade reservation */
    private let ptrReservation = UnsafeMutablePointer<CGDisplayFadeReservationToken>.allocate(capacity: 1)
    
    /** The timer for the blink interval. If it is nil, the blinker is not running. */
    private var timer : Timer?
    
    /** The interval at which to blink in seconds */
    private var _interval : TimeInterval = 10.0
    
    /** The interval at which to blink in seconds */
    var interval : TimeInterval {
        get { return _interval }
        set(newInterval) {
            stop()
            _interval = newInterval
            start()
        }
    }
    
    /** Starts the blinker in the current interval. */
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: _interval, repeats: true, block: {_ in
            self.blink()
        })
    }
    
    /** Stops the blinker */
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    /** Blinks the screen once */
    private func blink() {
        let error = CGAcquireDisplayFadeReservation(1.0, ptrReservation)
        
        func freeReservation() {
            
        }
        
        if (error != CGError.success) {
            // ignore reservation errors, we just skip the blink
            freeReservation()
            return
        }
        
        let duration : CGDisplayFadeInterval = 0.1
        let startBlend : CGDisplayBlendFraction = 0.0
        let endBlend : CGDisplayBlendFraction = 0.5
        
        CGDisplayFade(ptrReservation.pointee, duration / 2, startBlend, endBlend, 0.0, 0.0, 0.0, 1);
        CGDisplayFade(ptrReservation.pointee, duration / 2, endBlend, startBlend, 0.0, 0.0, 0.0, 1);
        
        freeReservation()
    }

    deinit {
        ptrReservation.deinitialize(count: 1)
        ptrReservation.deallocate()
    }
}
