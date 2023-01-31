//
//  TimerClass.swift
//  CSSI
//
//  Created by Aks on 31/01/23.
//  Copyright © 2023 yujdesigns. All rights reserved.
//

import Foundation
protocol CountdownTimerProtocol {
    func stopCountdown()
    func startCountdown(totalTime: Int, timerEnded: @escaping () -> Void, timerInProgress: @escaping (Int) -> Void)
}

class CountdownTimer: NSObject, CountdownTimerProtocol {
    private var timer: Timer?
    private var timeRemaining = 0
    var timerEndedCallback: (() -> Void)?
    var timerInProgressCallback: ((Int) -> Void)?
        
    deinit {
        stopCountdown()
    }
    
    func stopCountdown() {
        timer?.invalidate()
    }
    
    func startCountdown(totalTime: Int, timerEnded: @escaping () -> Void, timerInProgress: @escaping (Int) -> Void) {
        timeRemaining = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        timerEndedCallback = timerEnded
        timerInProgressCallback = timerInProgress
    }
    
    @objc func step() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            timerInProgressCallback?(timeRemaining)
        } else {
            stopCountdown()
            timerEndedCallback?()
        }
    }

}
