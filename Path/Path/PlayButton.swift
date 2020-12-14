//
//  PlayButton.swift
//  Path
//
//  Created by Patrick McKowen on 12/14/20.
//

import SwiftUI

struct PlayButton: View {
    @EnvironmentObject var timer: MeditationTimer
    @Binding var duration: TimeInterval
    var body: some View {
        Button(timer.state == .running ? "Pause" : "Start") {
            if timer.state == .running {
                timer.stop()
            } else if timer.state == .stopped {
                timer.start()
            } else {
                timer.duration = self.duration
                timer.start()
            }
        }
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(duration: .constant(300))
            .environmentObject(MeditationTimer())
    }
}
