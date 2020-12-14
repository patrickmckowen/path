//
//  PathApp.swift
//  Path
//
//  Created by Patrick McKowen on 11/3/20.
//

import SwiftUI
import CoreData

@main
struct PathApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var timer = MeditationTimer()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TimerView()
                .environmentObject(timer)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { scene in
            if scene == .active {
                print("App became active")
                print("Timer state: \(timer.state)")
                
                // Check for active streak or reset
                updateStreak()
                
                // Keep app running during meditation
                UIApplication.shared.isIdleTimerDisabled = true
            }
            if scene == .background {
                print("App moved to background")
                print("Timer state: \(timer.state)")
            }
            if scene == .inactive {
                print("App became inactive")
                print("Timer state: \(timer.state)")
            }
        }
    }
    
    func updateStreak() {
        print("Updating streak...")
        let fetchRequest: NSFetchRequest<Yogi> = Yogi.fetchRequest()
        fetchRequest.sortDescriptors = []
        let yogis = try? persistenceController.container.viewContext.fetch(fetchRequest)
        print("Yogi data fetched")
        if let yogi = yogis?.first {
            print("Yogi already exists")
            let lastSession = yogis?.first?.lastSessionDate ?? Date.distantPast
            print("Last session on \(lastSession)")
            if lastSession.isToday || lastSession.isYesterday {
                print("Keep streak alive")
            } else {
                yogi.currentStreak = 0
                print("Reset streak")
            }
        } else {
            print("No yogis")
        }
    }
}
