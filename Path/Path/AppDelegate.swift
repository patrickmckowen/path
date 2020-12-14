//
//  AppDelegate.swift
//  Path
//
//  Created by Patrick McKowen on 12/4/20.
//

import UIKit
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Setup audio
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
        } catch {
            print("Failed to set audio session in appDelegate \(error).")
        }
        
        return true
    }
}
