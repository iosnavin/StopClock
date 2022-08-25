//
//  StopWatch.swift
//  StopTimer
//
//  Created by Naveen Reddy on 23/08/22.
//

import Foundation
class StopTimer {
  
    //MARK: - Properties

    private let step: Double
    private var timer: Timer?
    
    private(set) var from: Date?
    private(set) var to: Date?
    
    private var timeIntervalTimelapsFrom: TimeInterval?
    private var timerSavedTime: TimeInterval = 0
    
    typealias TimeUpdated = (_ time: Double) -> Void
    let didUpdatedTime: TimeUpdated

    var isPaused: Bool {
        return timer == nil
    }
    
    init(step: Double = 1.0, didUpdatedTime: @escaping TimeUpdated) {
        self.step = step
        self.didUpdatedTime = didUpdatedTime
    }
    
    deinit {
        print("⏱ Stopwatch successfully deinited")
        deinitTimer()
    }
    
    //MARK: - Timer actions
    func toggle() {
        guard timer != nil else {
            createTimer()
            return
        }
        deinitTimer()
    }
    
    func stop() {
        deinitTimer()
        from = nil
        to = nil
        timerSavedTime = 0
        didUpdatedTime(0)
    }
    
    func pause() {
        deinitTimer()
    }
    
    private func createTimer() {
        let action: (Timer) -> Void = { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            let to = Date().timeIntervalSince1970
            let timeIntervalFrom = strongSelf.timeIntervalTimelapsFrom ?? to
            let time = strongSelf.timerSavedTime + (to - timeIntervalFrom)
            strongSelf.didUpdatedTime(round(time))
        }
        if from == nil {
            from = Date()
        }
        if timeIntervalTimelapsFrom == nil {
            timeIntervalTimelapsFrom = Date().timeIntervalSince1970
        }
        timer = Timer.scheduledTimer(withTimeInterval: step,
                                     repeats: true, block: action)
    }
    
    private func deinitTimer() {
        //Saving last timelaps
        if let timeIntervalTimelapsFrom = timeIntervalTimelapsFrom {
            let to = Date().timeIntervalSince1970
            timerSavedTime += to - timeIntervalTimelapsFrom
        }
        //Invalidating
        timer?.invalidate()
        timer = nil
        timeIntervalTimelapsFrom = nil
    }
}
