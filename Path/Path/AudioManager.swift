//
//  AudioManager.swift
//  Path
//
//  Created by Patrick McKowen on 12/4/20.
//

import AVFoundation

class AudioPlayer: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    
    func play() {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            let path = Bundle.main.path(forResource: "sound-bowl", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func stop() {
        do {
            let path = Bundle.main.path(forResource: "sound-bowl", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.stop()
        } catch {
            print("Error stopping sound: \(error)")
        }
    }
}

