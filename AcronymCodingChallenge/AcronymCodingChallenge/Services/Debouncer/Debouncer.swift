//
//  Debouncer.swift
//  AcronymCodingChallenge
//
//  Created by a2404643 on 14/02/23.
//

import Foundation

/// Timer class
/// It will be used to trigger the task after given time frame
/// Automatic initiate the task with the help of timer
public class Debouncer: NSObject {
    public var callback: (() -> Void)
    public var delay: Double
    public weak var timer: Timer?

    public init(delay: Double, callback: @escaping (() -> Void)) {
        self.delay = delay
        self.callback = callback
    }

    public func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(Debouncer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc func fireNow() {
        self.callback()
    }
}
