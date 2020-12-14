//
//  MeditationTimer.swift
//  Path
//
//  Created by Patrick McKowen on 11/24/20.
//

import Foundation

class MeditationTimer: ObservableObject {
    enum TimerMode {
        case off
        case running
        case stopped
        case completed
    }
    @Published var state: TimerMode = .off
    
    let bowlSound = AudioPlayer()
    var timer: Timer? = nil
    var duration = UserDefaults.standard.double(forKey: "TimerDuration")
    @Published var timeRemaining: TimeInterval = 0
    @Published var totalSessionTime: TimeInterval = 0
    
    func start() {
        if state == .off {
            timeRemaining = duration
            bowlSound.play()
        }
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true)
        timer!.tolerance = 0.2
        RunLoop.current.add(timer!, forMode:RunLoop.Mode.common)
        state = .running
    }
    
    @objc func fireTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            totalSessionTime += 1
        } else {
            state = .completed
            bowlSound.play()
            timer!.invalidate()
        }
    }
    
    func stop() {
        timer!.invalidate()
        bowlSound.stop()
        state = .stopped
    }
    
    func reset() {
        stop()
        timeRemaining = 0
        totalSessionTime = 0
        state = .off
    }
    
    func format(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i", minutes, seconds)
    }
}
