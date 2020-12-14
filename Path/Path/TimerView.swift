//
//  Timer.swift
//  Path
//
//  Created by Patrick McKowen on 11/12/20.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var timer: MeditationTimer
    @AppStorage("TimerDuration") var duration: TimeInterval = 300
    @FetchRequest(entity: Yogi.entity(), sortDescriptors: [])
    var yogis: FetchedResults<Yogi>
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                //Navbar
                if timer.state == .off {
                    Navbar()
                        .transition(.move(edge: .top))
                }
                
                // Countdown Text
                if timer.state != .off {
                    VStack {
                        Text(timer.format(timer.timeRemaining))
                            .onReceive(timer.$state) { state in
                                if state == .completed {
                                    showSheet = true
                                }
                            }
                        Spacer()
                    }
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .padding(.vertical, 32)
                    .transition(.scale)
                }
                
                // Play Button
                PlayButton(duration: $duration)
                
                // Duration Picker
                if timer.state == .off {
                    DurationPicker(selection: $duration)
                        .transition(.move(edge: .bottom))
                }
                
                // Reset Button
                if timer.state == .stopped {
                    VStack {
                        Spacer()
                        if timer.totalSessionTime > 300 {
                            Button(action: {
                                timer.state = .completed
                            }, label: {
                                Text("Save \(timer.format(timer.totalSessionTime)) session")
                            })
                        }
                        Button("Cancel") {
                            timer.reset()
                        }
                    }
                }
                
            } // end main ZStack
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showSheet, content: {
                SessionCompletedView()
                    .environmentObject(timer)
                    .environment(\.managedObjectContext, self.viewContext)
            })
        }
        
    } // end Body
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(MeditationTimer())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environment(\.colorScheme, .dark)
    }
}
