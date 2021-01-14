//
//  PlayButton.swift
//  Path
//
//  Created by Patrick McKowen on 12/14/20.
//

import SwiftUI

struct StartButton: View {
    @EnvironmentObject var timer: MeditationTimer
    @Binding var duration: TimeInterval
    var body: some View {
        ZStack {
          
            
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
            .foregroundColor(.black)
            .font(.system(size: 24, weight: .regular, design: .serif))
        }
        
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        StartButton(duration: .constant(300))
            .environmentObject(MeditationTimer())
            .environment(\.colorScheme, .dark)
    }
}
