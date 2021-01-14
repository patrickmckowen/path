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
    @State private var showPicker = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientSwirl()
                
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
                StartButton(duration: $duration)
                
                // Selected Duration
                Rectangle().fill(Color.black)
                        .opacity(showPicker ? 0.7 : 0)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.default) {
                                showPicker.toggle()
                            }
                        }
                if timer.state == .off {
                    VStack {
                        Spacer()
                        Text("\(duration / 60, specifier: "%.0f") minutes")
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .foregroundColor(.black)
                            .padding(.bottom, 48)
                            .onTapGesture {
                                withAnimation(.default) {
                                    showPicker.toggle()
                                }
                            }
                    }
                    .transition(.scale)
                }
                
                // Duration Picker
                if showPicker {
                    DurationPicker(showPicker: $showPicker, selection: $duration)
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
            .environment(\.colorScheme, .light)
    }
}
